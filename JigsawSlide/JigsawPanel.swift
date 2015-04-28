//
//  JigsawPanel.swift
//  JigsawSlide
//
//  Created by Sherlock Yao on 4/28/15.
//  Copyright (c) 2015 Sherlock Yao. All rights reserved.
//

import Foundation

enum JigsawBlock {
    case Rock
    case Piece(Int)
    case Slot
}

enum JigsawMove {
    case Up, Down, Left, Right
}

struct JigsawPanel {
    
    let blocks: [[JigsawBlock]]
    let rowCount: Int
    let columnCount: Int
    let slotPosition: (Int, Int)
    
    init?(pieces: [Int]) {
        if 15 != pieces.count {
            return nil
        }
        rowCount = 6
        columnCount = 3
        slotPosition = (0, 3)
        var blocks = [[JigsawBlock]](count: rowCount, repeatedValue: [JigsawBlock](count: columnCount, repeatedValue: .Rock))
        blocks[0][3] = .Slot
        for rowIndex in 1..<rowCount {
            for columnIndex in 0..<columnCount {
                let index = (rowIndex - 1) * columnCount + columnIndex
                blocks[rowIndex][columnIndex] = .Piece(index)
            }
        }
        self.blocks = blocks
    }
    
    init?(blocks: [[JigsawBlock]]) {
        if 6 != blocks.count || 3 != blocks[0].count {
            return nil
        }
        var slotCount: Int = 0
        var slotPosition: (Int, Int) = (0, 0)
        for rowIndex in 0..<blocks.count {
            for columnIndex in 0..<blocks[rowIndex].count {
                switch blocks[rowIndex][columnIndex] {
                case .Slot:
                    slotCount++
                    slotPosition = (rowIndex, columnIndex)
                default:
                    break
                }
            }
        }
        if 1 != slotCount {
            return nil
        }
        rowCount = 6
        columnCount = 3
        self.slotPosition = slotPosition
        self.blocks = blocks
    }
    
    func makeMove(move: JigsawMove) -> (JigsawPanel, Bool) {
        let nextSlotPosition = nextSlotPositionWithMove(move)
        let nextBlock = blockOfPosition(nextSlotPosition)
        switch nextBlock {
        case .Piece:
            return (panelByMoveBlock(nextSlotPosition), true)
        default:
            return (self, false)
        }
    }
    
    private func panelByMoveBlock(blockPosition: (Int, Int)) -> JigsawPanel {
        var blocks = self.blocks
        blocks[slotPosition.0][slotPosition.1] = blocks[blockPosition.0][blockPosition.1]
        blocks[blockPosition.0][blockPosition.1] = .Slot
        return JigsawPanel(blocks: blocks)!
    }
    
    private func nextSlotPositionWithMove(move: JigsawMove) -> (Int, Int) {
        let (rowIndex, columnIndex) = slotPosition
        switch move {
        case .Up:
            return (rowIndex + 1, columnIndex)
        case .Down:
            return (rowIndex - 1, columnIndex)
        case .Left:
            return (rowIndex, columnIndex - 1)
        case .Right:
            return (rowIndex, columnIndex + 1)
        }
    }
    
    private func blockOfPosition(position: (Int, Int)) -> JigsawBlock {
        let (rowIndex, columnIndex) = position
        if 0 > rowIndex || 0 > columnIndex || rowCount <= rowIndex || columnCount <= columnIndex {
            return JigsawBlock.Rock
        } else {
            return blocks[rowIndex][columnIndex]
        }
    }
}
