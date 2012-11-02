From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v2] Input: matrix-keypad - Add device tree support
Date: Fri, 2 Nov 2012 08:21:16 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA5E80B@DBDE01.ent.ti.com>
References: <1351684471-29369-1-git-send-email-anilkumar@ti.com>
 <50914433.1070805@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51355 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751696Ab2KBIV1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Nov 2012 04:21:27 -0400
In-Reply-To: <50914433.1070805@wwwdotorg.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "dgdunix@gmail.com" <dgdunix@gmail.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, Oct 31, 2012 at 21:00:59, Stephen Warren wrote:
> On 10/31/2012 05:54 AM, AnilKumar Ch wrote:
> > Add device tree support to matrix keypad driver and usage details
> > are added to device tree documentation. Driver was tested on AM335x
> > EVM.
> 
> > diff --git a/Documentation/devicetree/bindings/input/matrix-keypad.txt b/Documentation/devicetree/bindings/input/matrix-keypad.txt
> > new file mode 100644
> 
> > +- compatible:		Should be "gpio-matix-keypad"
> 
> There's a typo there.
> 
> Given that compatible value, shouldn't the file be named
> gpio-matrix-keypad.txt then?

Stephen,

Thanks for the comments.

I agree and I have same thing in my mind but the driver name
is matrix-keypad.c. And I think we have to change the driver
file names as well. (drivers/../matrix_keypad.c, linux/input/
matrix_keypad.h).

> 
> It seems like the property linux,keymap should be mentioned here too,
> with a note to read matrix-keymap.txt for the definition.

I will add a point to specify "details of linux,keymap are available at
matrix-keymap.txt"

> 
> > +Optional Properties:
> 
> > +- clustered-irq:	have clustered irq number
> > +- clustered-irq-flags:	have clustered irq flags
> 
> Explaining what those mean would be useful.

Sure.

Thanks
AnilKumar
