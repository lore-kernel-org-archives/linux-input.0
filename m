From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 0/8] Second patchset for LPC32xx device tree conversion
Date: Wed, 18 Apr 2012 08:06:16 +0000
Message-ID: <201204180806.16848.arnd@arndb.de>
References: <1334682507-15055-1-git-send-email-stigge@antcom.de>
 <20120417205001.GH6498@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120417205001.GH6498@mwanda>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Roland Stigge <stigge@antcom.de>, devel@driverdev.osuosl.org, srinivas.bakki@nxp.com, linux-usb@vger.kernel.org, broonie@opensource.wolfsonmicro.com, gregkh@linuxfoundation.org, thierry.reding@avionic-design.de, linux-kernel@vger.kernel.org, kevin.wells@nxp.com, marek.vasut@gmail.com, arm@kernel.org, linux-input@vger.kernel.org, axel.lin@gmail.com, dmitry.torokhov@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Tuesday 17 April 2012, Dan Carpenter wrote:
> On Tue, Apr 17, 2012 at 07:08:19PM +0200, Roland Stigge wrote:
> > Applies to v3.4-rc3
> > 
> 
> This probably applies fine (the previous version did a couple days
> ago), but it's always best to submit patches against linux-next.
> The 3.4 kernel is in -rc already so this is 3.5 material.

I disagree. The patches won't get applied on -next, they get applied
on an -rc release, so they should be submitted against that version
as well. I agree that it makes sense to test patches against -next
when there is reason to believe there might be conflicts, but it's
not mandatory. When you know about conflicts against other patches
that are already in -next, I suggest listing them in the cover 
letter (the patch 0/x) and suggest a resolution.

	Arnd
