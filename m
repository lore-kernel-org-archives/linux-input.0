From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: i8042 - add noloop quirk for Dell Embedded Box PC
 3000
Date: Tue, 7 Mar 2017 09:32:56 -0800
Message-ID: <20170307173256.GA13740@dtor-ws>
References: <20170306100306.8900-1-kai.heng.feng@canonical.com>
 <20170306104816.GA28703@xfiles>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35097 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755138AbdCGTd4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Mar 2017 14:33:56 -0500
Content-Disposition: inline
In-Reply-To: <20170306104816.GA28703@xfiles>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 06, 2017 at 07:48:18AM -0300, Marcos Paulo de Souza wrote:
> On Mon, Mar 06, 2017 at 06:03:06PM +0800, Kai-Heng Feng wrote:
> > The aux port does not get detected without noloop quirk, so external PS/2
> > mouse cannot work as result.
> > 
> > The PS/2 mouse can work with this quirk.
> > 
> > BugLink: https://bugs.launchpad.net/bugs/1591053
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> > index 05afd16ea9c9..e856b073d533 100644
> > --- a/drivers/input/serio/i8042-x86ia64io.h
> > +++ b/drivers/input/serio/i8042-x86ia64io.h
> > @@ -120,6 +120,13 @@ static const struct dmi_system_id __initconst i8042_dmi_noloop_table[] = {
> >  		},
> >  	},
> >  	{
> > +		/* Dell Embedded Box PC 3000 */
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "Embedded Box PC 3000"),
> > +		},
> > +	},
> > +	{
> >  		/* OQO Model 01 */
> >  		.matches = {
> >  			DMI_MATCH(DMI_SYS_VENDOR, "OQO"),
> 
> Reviewed-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>

Applied, thank you.

-- 
Dmitry
