Return-Path: <SRS0=gGDZ=EM=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A49AC2D0A3
	for <linux-input@archiver.kernel.org>; Fri,  6 Nov 2020 07:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE1C2208FE
	for <linux-input@archiver.kernel.org>; Fri,  6 Nov 2020 07:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgKFHuy (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 6 Nov 2020 02:50:54 -0500
Received: from smtprelay0115.hostedemail.com ([216.40.44.115]:53504 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725848AbgKFHuy (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 6 Nov 2020 02:50:54 -0500
X-Greylist: delayed 329 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Nov 2020 02:50:53 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id A8EBC1801BE96
        for <linux-input@vger.kernel.org>; Fri,  6 Nov 2020 07:45:24 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 39DD1100E7B45;
        Fri,  6 Nov 2020 07:45:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: magic28_0601ba1272d0
X-Filterd-Recvd-Size: 2193
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Fri,  6 Nov 2020 07:45:21 +0000 (UTC)
Message-ID: <b2cb1fc8aca53ef9ff5d3ff913f2ad4a5e95b1f9.camel@perches.com>
Subject: Re: [PATCH 10/20] input: mouse: synaptics: Place braces around
 empty if() body
From:   Joe Perches <joe@perches.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>,
        Peter Osterlund <petero2@telia.com>,
        Stefan Gmeiner <riddlebox@freesurf.ch>,
        "C. Scott Ananian" <cananian@alumni.priceton.edu>,
        Bruce Kalk <kall@compass.com>,
        this to <linux-input@vger.kernel.org>
Date:   Thu, 05 Nov 2020 23:45:20 -0800
In-Reply-To: <20201106072630.GD1003057@dtor-ws>
References: <20201104162427.2984742-1-lee.jones@linaro.org>
         <20201104162427.2984742-11-lee.jones@linaro.org>
         <20201106072630.GD1003057@dtor-ws>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, 2020-11-05 at 23:26 -0800, Dmitry Torokhov wrote:
> On Wed, Nov 04, 2020 at 04:24:17PM +0000, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/input/mouse/synaptics.c: In function ‘synaptics_process_packet’:
> >  drivers/input/mouse/synaptics.c:1110:6: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
[]
> > diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
[]
> > @@ -1106,8 +1106,9 @@ static void synaptics_process_packet(struct psmouse *psmouse)
> >  					num_fingers = hw.w + 2;
> >  				break;
> >  			case 2:
> > -				if (SYN_MODEL_PEN(info->model_id))
> > +				if (SYN_MODEL_PEN(info->model_id)) {
> >  					;   /* Nothing, treat a pen as a single finger */
> > +				}
> 
> This gives me:
> 
> WARNING: braces {} are not necessary for single statement blocks
> 
> from checkpatch.

As the entire case 2 is effectively a noop, why not just comment it better
and remove the if (SYN_MODEL_PEN(...)) test altogether.


