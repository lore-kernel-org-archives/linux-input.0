From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v6] Input: matrix-keypad - Add device tree support
Date: Thu, 15 Nov 2012 14:11:59 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA6C98F@DBDE01.ent.ti.com>
References: <1352976179-29790-1-git-send-email-anilkumar@ti.com>
 <50A4F488.5000808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47253 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933154Ab2KOOML convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Nov 2012 09:12:11 -0500
In-Reply-To: <50A4F488.5000808@gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "dgdunix@gmail.com" <dgdunix@gmail.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Nov 15, 2012 at 19:26:24, Rob Herring wrote:
> On 11/15/2012 04:42 AM, AnilKumar Ch wrote:
> > Add device tree support to matrix keypad driver and usage details
> > are added to device tree documentation. Also modified the driver
> > according to recent update of matrix_keypad_build_keymap(), which
> > automatically allocate memory for keymap.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> > This patch was tested on AM335x-EVM and based on linux-next, cleanly
> > applies on top of "input/next"
> > 
> > Changes from v5:
> > 	- Updated based on Dmitry's patch.
> > 	  * Modified the driver acc. to matrix_keypad_build_keymap()
> > 	    recent update.
> > 	  * Combined row_gpios & col_gpios devm_kzalloc's to single
> > 	    devm_kzalloc.
> > 	  * Added proper return values for different failures in
> > 	    matrix_keypad_parse_dt().
> > 
> > Changes from v4:
> > 	- Removed clustered-irq support through DT. This should be
> > 	  added if any platform requires in the future.
> > 
> > Changes from v3:
> > 	- Incorporated Stephen Warren's review comments on v3
> > 	  * Added description to clustered-irq-flags binding
> > 
> > Changes from v2:
> > 	- Incorporated Stephen Warren's review comments on v2
> > 	  * Renamed the bindings file to gpio-matrix-keypad.txt
> > 	  * Added description to clustered-irq binding
> > 
> > Changes from v1:
> > 	- Incorporated Rob's review comments on v1
> > 	  * Changed matix-keypad compatible to gpio-matrix-keypad
> > 	  * Removed unnecessary props (num of gpios)
> > 	  * Used of_match_ptr()
> > 	- Removed first patch based on Dmitry's comments on v1
> > 
> >  drivers/input/keyboard/matrix_keypad.c |  119 ++++++++++++++++++++++++++------
> 
> What happened to the binding doc?

Rebase mistake, right away I am resending the patch.

Thanks
AnilKumar
