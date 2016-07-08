From: "jeffrey.lin" <yajohn@gmail.com>
Subject: Re:[v1.1,3/3] modify raydium firmware update rule
Date: Fri,  8 Jul 2016 07:38:59 -0700
Message-ID: <1467988739-44544-1-git-send-email-jeffrey.lin@rad-ic.com>
References: <1467909578-43578-1-git-send-email-jeffrey.lin@rad-ic.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33588 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755025AbcGHOkG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jul 2016 10:40:06 -0400
In-Reply-To: <1467909578-43578-1-git-send-email-jeffrey.lin@rad-ic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@euromail.se, groeck@chromium.org, robh@kernel.org
Cc: jeffrey.lin@rad-ic.com, ealin.chiu@rad-ic.com, jason.yeh@rad-ic.com, KP.li@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi dmitry:
>> modify raydium touch firmware update rule.

>Why? You need to explain why you are proposing a change (but as I
>mentioned I see no reason for using custom file names for firmware. Have
>userspace adjust name as needed by the driver.

>Thanks.

Just want to easy to do firmware update version control in the factory. If do this,
factory do not easy update wrong version.

Thanks.

Jeffrey
