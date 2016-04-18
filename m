From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] Input: i8042 - Fix console keyboard support on Gen2
 Hyper-V VMs
Date: Mon, 18 Apr 2016 19:54:57 +0300
Message-ID: <20160418165456.GG4298@mwanda>
References: <1407814240-4275-1-git-send-email-decui@microsoft.com>
 <cover.1460985538.git.mdl@60hz.org>
 <341e0bb72d58c1c7d72ad5352f4bb364d939c0a8.1460985538.git.mdl@60hz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:22204 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbcDRQzT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Apr 2016 12:55:19 -0400
Content-Disposition: inline
In-Reply-To: <341e0bb72d58c1c7d72ad5352f4bb364d939c0a8.1460985538.git.mdl@60hz.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Laws <mdl@60hz.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, devel@linuxdriverproject.org, linux-input@vger.kernel.org

So if the user inserts the module without a keyboard then in the
original code they would just put a keyboard in and try again.  Now they
have to do an extra rmmod.  What about if we just removed the test for
if the keyboard is present?

On Tue, Apr 19, 2016 at 12:23:36AM +0900, Mark Laws wrote:
> As explained in 1407814240-4275-1-git-send-email-decui@microsoft.com:
> 
> > hyperv_keyboard invokes serio_interrupt(), which needs a valid serio
> > driver like atkbd.c.  atkbd.c depends on libps2.c because it invokes
> > ps2_command().  libps2.c depends on i8042.c because it invokes
> > i8042_check_port_owner().  As a result, hyperv_keyboard actually
> > depends on i8042.c.
> >
> > For a Generation 2 Hyper-V VM (meaning no i8042 device emulated), if a
> > Linux VM (like Arch Linux) happens to configure CONFIG_SERIO_I8042=m
> > rather than =y, atkbd.ko can't load because i8042.ko can't load(due to
> > no i8042 device emulated) and finally hyperv_keyboard can't work and
> > the user can't input: https://bugs.archlinux.org/task/39820
> > (Ubuntu/RHEL/SUSE aren't affected since they use CONFIG_SERIO_I8042=y)
> 
> The transitive dependency on i8042.c is non-trivial--there appears to be
> no obvious way to untangle it other than by duplicating much of atkbd.c
> within hyperv-keyboard--so we employ a simple workaround: keep i8042.ko
> loaded even if no i8042 device is detected, but set a flag so that any
> calls into the module simply return (since we don't want to try to
> interact with the non-existent i8042).  This allows atkbd.c and libps2.c
> to load, solving the problem.
> 
> Signed-off-by: Mark Laws <mdl@60hz.org>
> ---
>  drivers/input/serio/i8042.c | 41 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> index 4541957..4d49496 100644
> --- a/drivers/input/serio/i8042.c
> +++ b/drivers/input/serio/i8042.c
> @@ -132,6 +132,7 @@ struct i8042_port {
>  
>  static struct i8042_port i8042_ports[I8042_NUM_PORTS];
>  
> +static bool i8042_present;
>  static unsigned char i8042_initial_ctr;
>  static unsigned char i8042_ctr;
>  static bool i8042_mux_present;
> @@ -163,6 +164,9 @@ int i8042_install_filter(bool (*filter)(unsigned char data, unsigned char str,
>  	unsigned long flags;
>  	int ret = 0;
>  
> +	if (!i8042_present)
> +		return ret;

Don't obfuscate the literal.  Just "return 0;".  Also if it's goto out
just change that to "return 0;" because it's simpler for the reader.

regards,
dan carpenter

