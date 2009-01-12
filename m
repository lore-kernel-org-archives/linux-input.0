From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Touchpad on Dell Latitude XT (alps 73 00 14)
Date: Sun, 11 Jan 2009 23:58:11 -0800
Message-ID: <20090111235407.ZZRA012@mailhub.coreip.homeip.net>
References: <4967E317.6040407@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:35935 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbZALH6u (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Jan 2009 02:58:50 -0500
Received: by yw-out-2324.google.com with SMTP id 9so3369616ywe.1
        for <linux-input@vger.kernel.org>; Sun, 11 Jan 2009 23:58:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4967E317.6040407@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: linux-input@vger.kernel.org

Hi Rafi,

On Fri, Jan 09, 2009 at 06:51:51PM -0500, Rafi Rubin wrote:
> 
> My touchpad has the id 73,00,14 which I added to alps.c as
> { { 0x73, 0x00, 0x14 }, 0xf8, 0xf8, 0 }
> 
> How can I determine what values to use for those last three fields?
> 

f your touchpad works (you don't see any messages from psmouse in dmesg
and every button works fine) then these are correct values.

-- 
Dmitry
