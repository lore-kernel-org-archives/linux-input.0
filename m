From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH 1/2] Input: matrix-keypad - remove const from pointer to
 array of gpios
Date: Tue, 30 Oct 2012 13:08:25 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA5AD47@DBDE01.ent.ti.com>
References: <1350630373-24279-1-git-send-email-anilkumar@ti.com>
 <1350630373-24279-2-git-send-email-anilkumar@ti.com>
 <20121019230059.GB10915@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121019230059.GB10915@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "dgdunix@gmail.com" <dgdunix@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
List-Id: linux-input@vger.kernel.org

On Sat, Oct 20, 2012 at 04:30:59, Dmitry Torokhov wrote:
> On Fri, Oct 19, 2012 at 12:36:12PM +0530, AnilKumar Ch wrote:
> > Remove const from pointer to array of gpios in matrix_keypad_platform_data
> > struct. This is required if we update row_gpios and col_gpios based on
> > device tree data.
> 
> Then don't. Set them up via non-const aliases instead.
> 

Changed.

Thanks
AnilKumar
