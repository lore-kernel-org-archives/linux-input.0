From: Florian Echtler <floe@butterbrot.org>
Subject: Re: [PATCH v3] add sur40 driver for Samsung SUR40 (aka MS Surface
 2.0/Pixelsense)
Date: Sat, 16 Nov 2013 12:45:51 +0100
Message-ID: <52875AEF.2010109@butterbrot.org>
References: <1383748012-28880-1-git-send-email-floe@butterbrot.org> <20131111073105.GA7645@core.coreip.homeip.net> <5280AC87.4020905@butterbrot.org> <5280B0FE.5080203@euromail.se> <52822E8B.6030906@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:42515 "EHLO butterbrot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942Ab3KPLpy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Nov 2013 06:45:54 -0500
In-Reply-To: <52822E8B.6030906@butterbrot.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, dh.herrmann@gmail.com

Looks like the sur40 driver didn't make it into the 3.13 pull request, 
anything still missing/broken? I was hoping this might still make it 
into Ubuntu 14.04...

BR, Florian

Florian Echtler <floe@butterbrot.org> wrote:
>On 11.11.2013 11:27, Henrik Rydberg wrote:
>>  >> Also, does the patch below mess up or device or it still works?
>>> I'll test this tomorrow (no access to SUR40 today). If everything
>works,
>>> should I resubmit my patch with yours included or just tell you that
>>> it's fine?
>> No need to resubmit, a confirmation will do nicely. Thanks!
>> Henrik
>
>I've tested Dmitry's additional patch, confirmed to work. Just for the
>record:
>
>Tested-by: Florian Echtler <floe@butterbrot.org>
>
>BR, Florian
