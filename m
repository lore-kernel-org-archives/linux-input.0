From: Dan Carpenter <error27@gmail.com>
Subject: Re: [patch 2/2] usbhid: fix some error codes in hiddev_connect()
Date: Thu, 26 May 2011 19:35:22 +0300
Message-ID: <20110526163522.GH14591@shale.localdomain>
References: <20110526085018.GE14591@shale.localdomain>
 <alpine.LNX.2.00.1105261406260.28291@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33980 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748Ab1EZQfu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 May 2011 12:35:50 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1105261406260.28291@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: "open list:USB HID/HIDBP DRI..." <linux-usb@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, kernel-janitors@vger.kernel.org

On Thu, May 26, 2011 at 02:07:00PM +0200, Jiri Kosina wrote:
> Why would that matter?
>
> hid_connect() (which is the only caller) only checks for the return value 
> being (non-)zero.

It's just a cleanup.  It silences a Smatch complaint.

regards,
dan carpenter 
