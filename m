From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: EV_MSC/MSC_SCAN Behaviour
Date: Thu, 13 May 2010 00:54:38 -0700
Message-ID: <20100513075438.GE30110@core.coreip.homeip.net>
References: <27F9C60D11D683428E133F85D2BB4A53043E08FE1A@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:56597 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478Ab0EMHym (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 May 2010 03:54:42 -0400
Received: by pzk42 with SMTP id 42so558593pzk.4
        for <linux-input@vger.kernel.org>; Thu, 13 May 2010 00:54:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043E08FE1A@dlee03.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Arce, Abraham" <x0066660@ti.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, May 12, 2010 at 02:53:48PM -0500, Arce, Abraham wrote:
> Hi,
> 
> I have searched for documentation regarding this type of event but still not clear about the behaviour.
> 
> input_set_capability(input_dev, EV_MSC, MSC_SCAN);
> input_event(input_dev, EV_MSC, MSC_SCAN, code);
> 
> Without enabling it I am able to get events properly reported using evtest in key press, release and kept depressed
> 
>   Event: time 946684817.945892, type 1 (Key), code 18 (E), value 2
> 
> If I enable it then, If I press and release a key no code will be reported
> 
>   Event: time 946684836.854248, -------------- Report Sync ------------
>   Event: time 946684836.854248, -------------- Report Sync ------------
> 
> Unless I keep it depressed
> 
>   Event: time 946684817.945892, type 1 (Key), code 18 (E), value 2
> 
> And after releasing the key some other events will get generated
> 
>   Event: time 946684817.967559, type 4 (Misc), code 4 (ScanCode), value 24
>   Event: time 946684817.967559, -------------- Report Sync ------------
>   Event: time 946684817.967559, type 4 (Misc), code 4 (ScanCode), value 32
>   Event: time 946684817.967559, -------------- Report Sync ------------
>   Event: time 946684817.967590, type 4 (Misc), code 4 (ScanCode), value 40
>   Event: time 946684817.967590, -------------- Report Sync ------------
> 
> Am I missing something?
> 

Probably ;) Just send the code you have so far and we'll figure it out.

-- 
Dmitry
