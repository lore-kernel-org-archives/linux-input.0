From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: trackpoint - force 3 buttons if 0 button is
 reported
Date: Tue, 16 Jan 2018 15:07:13 -0800
Message-ID: <20180116230713.rppztybwe5ufhoxo@dtor-ws>
References: <20180112064658.25019-1-aaron.ma@canonical.com>
 <20180112083940.p36qj6ltzzwtuhng@dtor-ws>
 <06bbeca0-8a90-8935-9be3-f154db0b9fe9@canonical.com>
 <20180112181830.ccpkltghgkj3oh3e@dtor-ws>
 <6a96ce54-9f8a-2424-1e48-34ec6445cb8f@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42664 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeAPXHQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 16 Jan 2018 18:07:16 -0500
Content-Disposition: inline
In-Reply-To: <6a96ce54-9f8a-2424-1e48-34ec6445cb8f@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Ma <aaron.ma@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Jan 13, 2018 at 10:34:19AM +0800, Aaron Ma wrote:
> Will your patch go to stable kernel?
> If yes, that's fine.

Hmm, it looks like we need this patch after all as we do have screwy
Lenovos with apparently 0x01 devices reporting 0 buttons. From
https://bugzilla.kernel.org/show_bug.cgi?id=196253

 thinkpad_acpi: ThinkPad BIOS R0DET87W (1.87 ), EC unknown
 thinkpad_acpi: Lenovo ThinkPad E470, model 20H1004SGE

 psmouse serio2: trackpoint: IBM TrackPoint firmware: 0x0e, buttons: 0/0

I'll ask them to try my patch and if it is indeed 0x01 device I'll apply
your patch.

Thanks.

-- 
Dmitry
