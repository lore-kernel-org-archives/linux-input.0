From: "jeffrey.lin" <yajohn@gmail.com>
Subject: Re:[v1.1,3/3] modify raydium firmware update rule
Date: Sat,  9 Jul 2016 07:33:57 -0700
Message-ID: <1468074837-44718-1-git-send-email-jeffrey.lin@rad-ic.com>
References: <1467909578-43578-1-git-send-email-jeffrey.lin@rad-ic.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36214 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbcGIOey (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 9 Jul 2016 10:34:54 -0400
In-Reply-To: <1467909578-43578-1-git-send-email-jeffrey.lin@rad-ic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@euromail.se, groeck@chromium.org, robh@kernel.org
Cc: jeffrey.lin@rad-ic.com, ealin.chiu@rad-ic.com, jason.yeh@rad-ic.com, KP.li@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi dmitry:

>> >> modify raydium touch firmware update rule.
>> 
>> >Why? You need to explain why you are proposing a change (but as I
>> >mentioned I see no reason for using custom file names for firmware. Have
>> >userspace adjust name as needed by the driver.
>> 
>> >Thanks.
>> 
>> Just want to easy to do firmware update version control in the factory. If do this,
>> factory do not easy update wrong version.
>
>Just have your factory image rename firmware to canonical name before
>initiating update. There is no need to encumber kernel code with this.
Okay
Thanks.

Jeffrey.
