From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: Re: issues with unknown/new alias [retraction]
Date: Thu, 13 Sep 2012 09:49:41 +0100
Message-ID: <50519E25.7080007@gmail.com>
References: <50518A75.4030608@codemercs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:55935 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863Ab2IMItq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Sep 2012 04:49:46 -0400
In-Reply-To: <50518A75.4030608@codemercs.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christoph Jung <jung@codemercs.com>
Cc: linux-modules@vger.kernel.org, linux-input@vger.kernel.org

On 13/09/12 08:25, Christoph Jung wrote:
> Hello,
>
> I am from the company "Code Mercenaries GmbH" from Germany. We have 
> some USB HID devices wich work with Linux.
> Since kernel version 2.6 our default products will be included in the 
> kernel.
>
> Devicedetails
> VendorID: 0x07C0
> ProductIDs: 0x1500, 0x1501, 0x1511, 0x1512, 0x1503
> Devicename: iowarrior
>
> Now we have some new custom product IDs but this two new devices get 
> no node in dev/usb/ , but I can find the with "lsusb".
> If I run "modinfo iowarrior" there will be 5 alias (with the default 
> pIDs) .
>
> The two new pIDs are: 0x158A, 0x158B
>
> I have not much experiance with linux (I work with Ubuntu 12.04). What 
> have be done to get the device nodes to work with them?
> Have I add some rules? Or have I edit the iowarrior.ko?
>
Argh, sorry, I misread your email and went off on one.

You will indeed need to "edit iowarrior.ko".  I.e. change the C source 
code to include the new pIDs, recompile, test, get patches merged into 
the mainline kernel etc :).

It's also possible to test new devices with an old driver, i.e. before 
you modify it.  Possible instructions: http://www.ha19.no/usb/

Alan
