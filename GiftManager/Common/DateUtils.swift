//
//  DateUtils.swift
//  GiftManager
//
//  Created by Dave on 1/6/18.
//  Copyright © 2018 org.djohnson. All rights reserved.
//
import Foundation

/**
* Various helper methods for manipulating and formating dates.
*
*/
class DateUtils
{
	private static let formatyyyyMMddHHmm = "yyyy-MM-dd HH:mm"
	
	private static let formatMMdd = "MM-dd"
	
	private static let formatyyyyMMdd = "yyyy-MM-dd"
	
	private static let formatyyyMMddNoDash = "yyyyMMdd"
	
	/**
	Format a date time object to a date only format string. yyyy-MM-dd
	- parameter strTimestamp:  The timestamp (NSDate) to format.
	- returns: Formatted date string.
	*/
	static func formatDateyyyyMMddHHmm(timestamp:Date) -> String
	{
		let formatter :DateFormatter = DateFormatter()
		formatter.dateFormat = formatyyyyMMddHHmm
		return  formatter.string(from: timestamp)
	}
	
	/**
	Format a date time object to a short format string. MM-dd
	- parameter strTimestamp:  The timestamp (NSDate) to format.
	- returns: Formatted date string.
	*/
	static func formatDateMMdd(timestamp:Date) -> String
	{
		let formatter :DateFormatter = DateFormatter()
		formatter.dateFormat = formatMMdd
		return  formatter.string(from: timestamp)
	}
	
	/**
	Format a date time object to a short format string. yyyy-MM-dd
	- parameter strTimestamp:  The timestamp (NSDate) to format.
	- returns: Formatted date string.
	*/
	static func formatDateYyyyMMdd(timestamp:Date) -> String
	{
		let formatter :DateFormatter = DateFormatter()
		formatter.dateFormat = formatyyyyMMdd
		return  formatter.string(from: timestamp)
	}
	
	/**
	Format a date time object to a short format string. yyyyMMdd
	- parameter strTimestamp:  The timestamp (NSDate) to format.
	- returns: Formatted date string.
	*/
	static func formatDateYyyyMMddNoDash(timestamp:Date) -> String
	{
		let formatter :DateFormatter = DateFormatter()
		formatter.dateFormat = formatyyyMMddNoDash
		return  formatter.string(from: timestamp)
	}
	
	
}

