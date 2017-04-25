From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Input: mouse: Trackpoint middle button not recognized on
 Thinkpad E470
Date: Tue, 25 Apr 2017 15:10:14 -0700
Message-ID: <20170425221014.GD30843@dtor-ws>
References: <13710506-2225-9f81-40e3-7463ac829860@techfak.uni-bielefeld.de>
 <f516c725-48d8-6f82-5ac7-c6afee303e59@techfak.uni-bielefeld.de>
 <20170425211633.bl72ajw5duwdpq4j@beacon.debie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:36550 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1432733AbdDYWKS (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 25 Apr 2017 18:10:18 -0400
Received: by mail-it0-f53.google.com with SMTP id g66so28458516ite.1
        for <linux-input@vger.kernel.org>; Tue, 25 Apr 2017 15:10:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170425211633.bl72ajw5duwdpq4j@beacon.debie>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ulrik.debie-os@e2big.org
Cc: Julian Exner <jexner@techfak.uni-bielefeld.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, aduggan@synaptics.com

On Tue, Apr 25, 2017 at 11:16:33PM +0200, ulrik.debie-os@e2big.org wrote:
> Hi Julian, Dmitry,
> 
> I have a similar behaviour for thinkpad e570 trackpoint. Manually forcing 
> button_info also made the middle button work.
> Julian, I planned to go the investigation road just when I happened to see
> your email. 
> 
> Dmitry, what do you suggest as a path forward when
> extended-button-data command fails ? Check for DMI and whitelist 3button
> for certain laptops which will be a growing list (2 laptops known already)? 
> Default to 3 buttons when extended-button-data command fails ?

Hmm.. I do not recall seeing real trackpoints with only 2 buttons. Let's
try defaulting to 3 and see what happens.

> 
> Julian, feel free to propose a patch, I'll review and test on E570.
> 
> Kind regards,
> Ulrik
> 
> 
> 
> On Tue, Apr 25, 2017 at 10:06:56PM +0200, Julian Exner wrote:
> > Date:   Tue, 25 Apr 2017 22:06:56 +0200
> > From: Julian Exner <jexner@techfak.uni-bielefeld.de>
> > To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
> > Cc: aduggan@synaptics.com
> > Subject: Re: Input: mouse: Trackpoint middle button not recognized on
> >  Thinkpad E470
> > X-Mailing-List: linux-input@vger.kernel.org
> > 
> > I checked the Trackpoint specification [1] and apparently 0xFE stands for
> > the Trackpoint controller asking to resend the command due to invalid input.
> > Resending the extended-button-data command results in 0xFC which stands for
> > another invalid input. But 0xFE does not only stand for a resend request but
> > might also mean that the issued command is not implemented in the ROM. [2]
> > 
> > So maybe when the extended-button-data command is not support, we can check
> > for certain Trackpoint or ROM ids to deduce if a middle button is present.
> > If you think this is the right approach I may craft a patch for this.
> > 
> > [1] http://blogs.epfl.ch/icenet/documents/Ykt3Eext.pdf
> > [2] http://blogs.epfl.ch/icenet/documents/Ykt3Eext.pdf#page=20
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-input" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
