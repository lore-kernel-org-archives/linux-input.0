From: Tai-hwa Liang <avatar@sentelic.com>
Subject: Re: [linux 2.6] new mouse driver looking for review and integration
 (fwd)
Date: Fri, 8 May 2009 13:30:52 +0800 (CST)
Message-ID: <0905081258371.25111@cnaqrzbavhz.fragryvp.pbz>
References: <0810211135259.24686@cnaqrzbavhz.fragryvp.pbz>
 <20081030184450.GA18874@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.sentelic.com ([203.69.18.19]:12438 "EHLO www.sentelic.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481AbZEHF6E (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 8 May 2009 01:58:04 -0400
In-Reply-To: <20081030184450.GA18874@anvil.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi, Dmitry,

   I'm wondering about the status of the patch you submitted to git.  Will it 
being merged into 2.6.31?

On Thu, 30 Oct 2008, Dmitry Torokhov wrote:
> Dear Tai-hwa,
>
> On Tue, Oct 21, 2008 at 11:36:05AM +0800, Tai-hwa Liang wrote:
>> ---------- Forwarded message ----------
>> Date: Fri, 17 Oct 2008 15:35:35 +0800 (CST)
>> From: Tai-hwa Liang <avatar@sentelic.com>
>> To: dmitry.torokhov@gmail.com
>> Subject: Re: [linux 2.6] new mouse driver looking for review and integration
>>     (fwd)
>>
>> [Not sure if the linux-input mailing list still exists. I'm sending you based
>> on the address found in MAINTAINERS file]
>>
>> Greetings,
>>
>>   The attached is the latest driver for Sentelic Finger Sensing Pad which
>> can be found on MSI WIND Netbook.  Since there are many user requests
>> for official Linux driver, we are still looking for getting this
>> implementation being merged into the mainstream kernel tree.
>>
>>   I would be very appreciate it if you can review them.
>>
>
> I finally had some time to review the code and I believe it is in a good
> shape but I would like to adjust it a little bit to integrate it better
> with the rest of psmouse code. The patch below is what I currently have
> relative to what you sent to me.
>
> Breakdown of the changes:
>
> - fsp_ps2_command() - I removed it and instead used ps2_sendbyte in the
>   most places;
> - while reading and writing registers cmd_mutex is held ensuring
>   uninterruped operation
> - while reading registers psmouse is switched to command mode to not
>   confuse interrupt handler
> - use attribute_group to simplify creating multiple attributes
> - some formatting changes
[...]
>
> -- 
> Dmitry
> 
> Input: various fixups to Sentelic driver
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>  drivers/input/mouse/Kconfig        |    8
>  drivers/input/mouse/Makefile       |    1
>  drivers/input/mouse/psmouse-base.c |   18 -
>  drivers/input/mouse/sentelic.c     |  857 ++++++++++++++----------------------
>  drivers/input/mouse/sentelic.h     |   39 +-
>  drivers/input/serio/libps2.c       |   15 +
>  include/linux/libps2.h             |    1
>  7 files changed, 399 insertions(+), 540 deletions(-)
> 
> diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
> index 4e99342..6c87b68 100644
> --- a/drivers/input/mouse/Kconfig
> +++ b/drivers/input/mouse/Kconfig
> @@ -107,6 +107,14 @@ config MOUSE_PS2_ELANTECH
>  	  entries. For further information,
>  	  see <file:Documentation/input/elantech.txt>.
> 
> +config MOUSE_PS2_SENTELIC
> +	bool "Sentelic Finger Sensing Pad PS/2 protocol extension"
> +	depends on MOUSE_PS2
> +	help
> +	  Say Y here if you have a laptop (such as MSI WIND Netbook)
> +	  with Sentelic Finger Sensing Pad touchpad.
> +
> +	  If unsure, say N.
>
>  config MOUSE_PS2_TOUCHKIT
>  	bool "eGalax TouchKit PS/2 protocol extension"
> diff --git a/drivers/input/mouse/Makefile b/drivers/input/mouse/Makefile
> index 0594f28..9eaf422 100644
> --- a/drivers/input/mouse/Makefile
> +++ b/drivers/input/mouse/Makefile
> @@ -25,5 +25,6 @@ psmouse-$(CONFIG_MOUSE_PS2_ELANTECH)	+= elantech.o
>  psmouse-$(CONFIG_MOUSE_PS2_OLPC)	+= hgpk.o
>  psmouse-$(CONFIG_MOUSE_PS2_LOGIPS2PP)	+= logips2pp.o
>  psmouse-$(CONFIG_MOUSE_PS2_LIFEBOOK)	+= lifebook.o
> +psmouse-$(CONFIG_MOUSE_PS2_SENTELIC)	+= sentelic.o
>  psmouse-$(CONFIG_MOUSE_PS2_TRACKPOINT)	+= trackpoint.o
>  psmouse-$(CONFIG_MOUSE_PS2_TOUCHKIT)	+= touchkit_ps2.o
> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
> index 2862ad6..4683b13 100644
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
> @@ -761,13 +761,6 @@ static const struct psmouse_protocol psmouse_protocols[] = {
>  		.maxproto	= 1,
>  		.detect		= intellimouse_detect,
>  	},
> - 	{
> -		.type		= PSMOUSE_FSP,
> -		.name		= "FSPPS/2",
> -		.alias		= "fsp",
> -		.detect		= fsp_detect,
> -		.init		= fsp_init,
> -	},
>  	{
>  		.type		= PSMOUSE_IMEX,
>  		.name		= "ImExPS/2",
> @@ -833,7 +826,16 @@ static const struct psmouse_protocol psmouse_protocols[] = {
>  		.detect		= elantech_detect,
>  		.init		= elantech_init,
>  	},
> - #endif
> +#endif
> +#ifdef CONFIG_MOUSE_PS2_SENTELIC
> +	{
> +		.type		= PSMOUSE_FSP,
> +		.name		= "FSPPS/2",
> +		.alias		= "fsp",
> +		.detect		= fsp_detect,
> +		.init		= fsp_init,
> +	},
> +#endif
>  	{
>  		.type		= PSMOUSE_CORTRON,
>  		.name		= "CortronPS/2",
> diff --git a/drivers/input/mouse/sentelic.c b/drivers/input/mouse/sentelic.c
> index 37a07a3..f44854e 100644
> --- a/drivers/input/mouse/sentelic.c
> +++ b/drivers/input/mouse/sentelic.c
> @@ -17,8 +17,6 @@
>   *   You should have received a copy of the GNU General Public License
>   *   along with this program; if not, write to the Free Software
>   *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> - *
> - * $Id: sentelic.c 28732 2008-10-17 07:03:29Z avatar $
>   */
>
>  #include <linux/module.h>
> @@ -32,100 +30,27 @@
>  #include "psmouse.h"
>  #include "sentelic.h"
> 
> -/**
> - * The timeout for FSP PS/2 command only (in milliseconds).
> +/*
> + * Timeout for FSP PS/2 command and subsequent arguments
>   */
> -#define	FSP_CMD_TIMEOUT		(30)
> +#define	FSP_CMD_TIMEOUT		200
> +#define	FSP_CMD_TIMEOUT2	30
>
>  /** Driver version. */
>  static unsigned int	fsp_drv_ver[] = {1, 0, 0};
>
>  #ifdef	FSP_DEBUG
> -static unsigned int	ps2_packet_cnt;
> -static unsigned int	ps2_last_second;
> +static unsigned int ps2_packet_cnt;
> +static unsigned int ps2_last_second;
>  #endif
> 
> -/*
> - * A direct copy of ps2_command(), with reduced timeout value as the hardware
> - * will return non-standard response which results in timeout in almost all
> - * commanding sequences.
> - */
> -static int
> -fsp_ps2_command(struct psmouse *psmouse, unsigned char *param, int command)
> -{
> -	struct ps2dev	*ps2dev = &psmouse->ps2dev;
> -	int		timeout;
> -	int		send = (command >> 12) & 0xf;
> -	int		receive = (command >> 8) & 0xf;
> -	int		rc = -1;
> -	int		i;
> -
> -	if (receive > sizeof(ps2dev->cmdbuf)) {
> -		WARN_ON(1);
> -		return (-1);
> -	}
> -
> -	if (send && !param) {
> -		WARN_ON(1);
> -		return (-1);
> -	}
> -
> -	mutex_lock(&ps2dev->cmd_mutex);
> -
> -	serio_pause_rx(ps2dev->serio);
> -	ps2dev->flags = command == PS2_CMD_GETID ? PS2_FLAG_WAITID : 0;
> -	ps2dev->cmdcnt = receive;
> -	if (receive && param)
> -		for (i = 0; i < receive; i++)
> -			ps2dev->cmdbuf[(receive - 1) - i] = param[i];
> -	serio_continue_rx(ps2dev->serio);
> -
> -	if (ps2_sendbyte(ps2dev, command & 0xff,
> -	    command == PS2_CMD_RESET_BAT ? 1000 : FSP_CMD_TIMEOUT))
> -		goto out;
> -
> -	for (i = 0; i < send; i++) {
> -		if (ps2_sendbyte(ps2dev, param[i], FSP_CMD_TIMEOUT))
> -			goto out;
> -	}
> -
> -	/*
> -	 * The reset command takes a long time to execute.
> -	 */
> -	timeout = msecs_to_jiffies(command == PS2_CMD_RESET_BAT ? 4000 : 500);
> -
> -	timeout = wait_event_timeout(ps2dev->wait,
> -	    !(ps2dev->flags & PS2_FLAG_CMD1), timeout);
> -
> -	if (ps2dev->cmdcnt && timeout > 0) {
> -		wait_event_timeout(ps2dev->wait,
> -		    !(ps2dev->flags & PS2_FLAG_CMD), timeout);
> -	}
> -
> -	if (param) {
> -		for (i = 0; i < receive; i++)
> -			param[i] = ps2dev->cmdbuf[(receive - 1) - i];
> -	}
> -
> -	if (ps2dev->cmdcnt && (command != PS2_CMD_RESET_BAT || ps2dev->cmdcnt != 1))
> -		goto out;
> -
> -	rc = 0;
> -out:
> -	serio_pause_rx(ps2dev->serio);
> -	ps2dev->flags = 0;
> -	serio_continue_rx(ps2dev->serio);
> -
> -	mutex_unlock(&ps2dev->cmd_mutex);
> -	return (rc);
> -}
> +int fsp_reset(struct psmouse *psmouse);
>
>  /*
>   * Make sure that the value being sent to FSP will not conflict with
>   * possible sample rate values.
>   */
> -static unsigned char
> -fsp_test_swap_cmd(unsigned char reg_val)
> +static unsigned char fsp_test_swap_cmd(unsigned char reg_val)
>  {
>  	switch (reg_val) {
>  	case 10: case 20: case 40: case 60: case 80: case 100: case 200:
> @@ -134,9 +59,9 @@ fsp_test_swap_cmd(unsigned char reg_val)
>  		 * sample rates, swap the given value such that the hardware
>  		 * wouldn't get confused.
>  		 */
> -		return ((reg_val >> 4) | (reg_val << 4));
> +		return (reg_val >> 4) | (reg_val << 4);
>  	default:
> -		return (reg_val);	/* swap isn't necessary */
> +		return reg_val;	/* swap isn't necessary */
>  	}
>  }
> 
> @@ -144,8 +69,7 @@ fsp_test_swap_cmd(unsigned char reg_val)
>   * Make sure that the value being sent to FSP will not conflict with certain
>   * commands.
>   */
> -static unsigned char
> -fsp_test_invert_cmd(unsigned char reg_val)
> +static unsigned char fsp_test_invert_cmd(unsigned char reg_val)
>  {
>  	switch (reg_val) {
>  	case 0xe9: case 0xee: case 0xf2: case 0xff:
> @@ -154,299 +78,328 @@ fsp_test_invert_cmd(unsigned char reg_val)
>  		 * commands, inverse the given value such that the hardware
>  		 * wouldn't get confused.
>  		 */
> -		return ~(reg_val);
> +		return ~reg_val;
>  	default:
> -		return (reg_val);	/* inversion isn't necessary */
> +		return reg_val;	/* inversion isn't necessary */
>  	}
>  }
> 
> -static int
> -fsp_reg_read(struct psmouse *psmouse, int reg_addr, int *reg_val)
> +static int fsp_reg_read(struct psmouse *psmouse, int reg_addr, int *reg_val)
>  {
> -	unsigned char	param[3];
> -	unsigned char	addr;
> -#ifdef	FSP_DEBUG
> -	printk(KERN_INFO "fsp_reg_read: READ REG\n");
> -#endif
> -	if (fsp_ps2_command(psmouse, NULL, 0x00f3) < 0)
> -		return (-1);
> +	struct ps2dev *ps2dev = &psmouse->ps2dev;
> +	unsigned char param[3];
> +	unsigned char addr;
> +	int rc = -1;
> +
> +	/*
> +	 * We need to shut off the device and switch it into command
> +	 * mode so we don't confuse our protocol handler. We don't need
> +	 * to do that for writes because sysfs set helper does this for
> +	 * us.
> +	 */
> +	ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE);
> +	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
> +	mutex_lock(&ps2dev->cmd_mutex);
> +
> +	if (ps2_sendbyte(ps2dev, 0xf3, FSP_CMD_TIMEOUT) < 0)
> +		goto out;
>
>  	/* should return 0xfe(request for resending) */
> -	fsp_ps2_command(psmouse, NULL, 0x0066);
> +	ps2_sendbyte(ps2dev, 0x66, FSP_CMD_TIMEOUT2);
>  	/* should return 0xfc(failed) */
> -	fsp_ps2_command(psmouse, NULL, 0x0088);
> +	ps2_sendbyte(ps2dev, 0x88, FSP_CMD_TIMEOUT2);
> 
> -	if (fsp_ps2_command(psmouse, NULL, 0x00f3) < 0)
> -		return (-1);
> +	if (ps2_sendbyte(ps2dev, 0xf3, FSP_CMD_TIMEOUT) < 0)
> +		goto out;
>
>  	if ((addr = fsp_test_invert_cmd(reg_addr)) != reg_addr) {
> -		fsp_ps2_command(psmouse, NULL, 0x0068);
> +		ps2_sendbyte(ps2dev, 0x68, FSP_CMD_TIMEOUT2);
> +	} else if ((addr = fsp_test_swap_cmd(reg_addr)) != reg_addr) {
> +		/* swapping is required */
> +		ps2_sendbyte(ps2dev, 0xcc, FSP_CMD_TIMEOUT2);
> +		/* expect 0xfe */
>  	} else {
> -		if ((addr = fsp_test_swap_cmd(reg_addr)) != reg_addr) {
> -			/* swapping is required */
> -			fsp_ps2_command(psmouse, NULL, 0x00cc);
> -			/* expect 0xfe */
> -		} else {
> -			/* swapping isn't necessary */
> -			fsp_ps2_command(psmouse, NULL, 0x0066);
> -			/* expect 0xfe */
> -		}
> +		/* swapping isn't necessary */
> +		ps2_sendbyte(ps2dev, 0x66, FSP_CMD_TIMEOUT2);
> +		/* expect 0xfe */
>  	}
>  	/* should return 0xfc(failed) */
> -	fsp_ps2_command(psmouse, NULL, addr);
> +	ps2_sendbyte(ps2dev, addr, FSP_CMD_TIMEOUT);
> 
> -	if (fsp_ps2_command(psmouse, param, PSMOUSE_CMD_GETINFO) < 0)
> -		return (-1);
> +	if (__ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO) < 0)
> +		goto out;
>
>  	*reg_val = param[2];
> +	rc = 0;
> 
> -	return (0);
> + out:
> +	mutex_unlock(&ps2dev->cmd_mutex);
> +	ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE);
> +	psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
> +	dev_dbg(&ps2dev->serio->dev, "READ REG: 0x%02x is 0x%02x (rc = %d)\n",
> +		reg_addr, *reg_val, rc);
> +	return rc;
>  }
> 
> -static int
> -fsp_reg_write(struct psmouse *psmouse, int reg_addr, int reg_val)
> +static int fsp_reg_write(struct psmouse *psmouse, int reg_addr, int reg_val)
>  {
> -	unsigned char	v;
> -#ifdef	FSP_DEBUG
> -	printk(KERN_INFO "fsp_reg_write: WRITE REG\n");
> -#endif
> -	if (fsp_ps2_command(psmouse, NULL, 0x00f3) < 0)
> -		return (-1);
> +	struct ps2dev *ps2dev = &psmouse->ps2dev;
> +	unsigned char v;
> +	int rc = -1;
> +
> +	mutex_lock(&ps2dev->cmd_mutex);
> +
> +	if (ps2_sendbyte(ps2dev, 0xf3, FSP_CMD_TIMEOUT) < 0)
> +		goto out;
>
>  	if ((v = fsp_test_invert_cmd(reg_addr)) != reg_addr) {
>  		/* inversion is required */
> -		fsp_ps2_command(psmouse, NULL, 0x0074);
> +		ps2_sendbyte(ps2dev, 0x74, FSP_CMD_TIMEOUT2);
>  	} else {
>  		if ((v = fsp_test_swap_cmd(reg_addr)) != reg_addr) {
>  			/* swapping is required */
> -			fsp_ps2_command(psmouse, NULL, 0x0077);
> +			ps2_sendbyte(ps2dev, 0x77, FSP_CMD_TIMEOUT2);
>  		} else {
>  			/* swapping isn't necessary */
> -			fsp_ps2_command(psmouse, NULL, 0x0055);
> +			ps2_sendbyte(ps2dev, 0x55, FSP_CMD_TIMEOUT2);
>  		}
>  	}
>  	/* write the register address in correct order */
> -	fsp_ps2_command(psmouse, NULL, v);
> +	ps2_sendbyte(ps2dev, v, FSP_CMD_TIMEOUT2);
> 
> -	if (fsp_ps2_command(psmouse, NULL, 0x00f3) < 0)
> -		return (-1);
> +	if (ps2_sendbyte(ps2dev, 0xf3, FSP_CMD_TIMEOUT) < 0)
> +		return -1;
>
>  	if ((v = fsp_test_invert_cmd(reg_val)) != reg_val) {
>  		/* inversion is required */
> -		fsp_ps2_command(psmouse, NULL, 0x0047);
> +		ps2_sendbyte(ps2dev, 0x47, FSP_CMD_TIMEOUT2);
> +	} else if ((v = fsp_test_swap_cmd(reg_val)) != reg_val) {
> +		/* swapping is required */
> +		ps2_sendbyte(ps2dev, 0x44, FSP_CMD_TIMEOUT2);
>  	} else {
> -		if ((v = fsp_test_swap_cmd(reg_val)) != reg_val) {
> -			/* swapping is required */
> -			fsp_ps2_command(psmouse, NULL, 0x0044);
> -		} else {
> -			/* swapping isn't necessary */
> -			fsp_ps2_command(psmouse, NULL, 0x0033);
> -		}
> +		/* swapping isn't necessary */
> +		ps2_sendbyte(ps2dev, 0x33, FSP_CMD_TIMEOUT2);
>  	}
> +
>  	/* write the register value in correct order */
> -	fsp_ps2_command(psmouse, NULL, v);
> +	ps2_sendbyte(ps2dev, v, FSP_CMD_TIMEOUT2);
> +	rc = 0;
> 
> -	return (0);
> + out:
> +	mutex_unlock(&ps2dev->cmd_mutex);
> +	dev_dbg(&ps2dev->serio->dev, "WRITE REG: 0x%02x to 0x%02x (rc = %d)\n",
> +		reg_addr, reg_val, rc);
> +	return rc;
>  }
>
>  /* enable register clock gating for writing certain registers */
> -static int
> -fsp_reg_write_enable(struct psmouse *psmouse, int en)
> +static int fsp_reg_write_enable(struct psmouse *psmouse, int en)
>  {
> -	int	v, nv;
> +	int v, nv;
>
>  	if (fsp_reg_read(psmouse, FSP_REG_SYSCTL1, &v) == -1)
> -		return (-1);
> +		return -1;
> 
> -	if (en) {
> +	if (en)
>  		nv = v | FSP_BIT_EN_REG_CLK;
> -	} else {
> -		nv = v & ~(FSP_BIT_EN_REG_CLK);
> -	}
> +	else
> +		nv = v & ~FSP_BIT_EN_REG_CLK;
> +
>  	/* only write if necessary */
> -	if (nv != v) {
> +	if (nv != v)
>  		if (fsp_reg_write(psmouse, FSP_REG_SYSCTL1, nv) == -1)
> -			return (-1);
> -	}
> -	return (0);
> +			return -1;
> +
> +	return 0;
>  }
> 
> -static int
> -fsp_page_reg_read(struct psmouse *psmouse, int *reg_val)
> +static int fsp_page_reg_read(struct psmouse *psmouse, int *reg_val)
>  {
> -	unsigned char	param[3];
> -#ifdef	FSP_DEBUG
> -	printk(KERN_INFO "fsp_page_reg_read: READ PAGE REG\n");
> -#endif
> -	if (fsp_ps2_command(psmouse, NULL, 0x00f3) < 0)
> -		return (-1);
> +	struct ps2dev *ps2dev = &psmouse->ps2dev;
> +	unsigned char param[3];
> +	int rc = -1;
> 
> -	fsp_ps2_command(psmouse, NULL, 0x0066);
> -	fsp_ps2_command(psmouse, NULL, 0x0088);
> +	ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE);
> +	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
> +	mutex_lock(&ps2dev->cmd_mutex);
> +
> +	if (ps2_sendbyte(ps2dev, 0xf3, FSP_CMD_TIMEOUT) < 0)
> +		goto out;
> 
> -	if (fsp_ps2_command(psmouse, NULL, 0x00f3) < 0)
> -		return (-1);
> +	ps2_sendbyte(ps2dev, 0x66, FSP_CMD_TIMEOUT2);
> +	ps2_sendbyte(ps2dev, 0x88, FSP_CMD_TIMEOUT2);
> 
> -	fsp_ps2_command(psmouse, NULL, 0x0083);
> -	fsp_ps2_command(psmouse, NULL, 0x0088);
> +	if (ps2_sendbyte(ps2dev, 0xf3, FSP_CMD_TIMEOUT) < 0)
> +		goto out;
> +
> +	ps2_sendbyte(ps2dev, 0x83, FSP_CMD_TIMEOUT2);
> +	ps2_sendbyte(ps2dev, 0x88, FSP_CMD_TIMEOUT2);
>
>  	/* get the returned result */
> -	if (fsp_ps2_command(psmouse, param, PSMOUSE_CMD_GETINFO))
> -		return (-1);
> +	if (__ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
> +		goto out;
>
>  	*reg_val = param[2];
> +	rc = 0;
> 
> -	return (0);
> + out:
> +	mutex_unlock(&ps2dev->cmd_mutex);
> +	ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE);
> +	psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
> +	dev_dbg(&ps2dev->serio->dev, "READ PAGE REG: 0x%02x (rc = %d)\n",
> +		*reg_val, rc);
> +	return rc;
>  }
> 
> -static int
> -fsp_page_reg_write(struct psmouse *psmouse, int reg_val)
> +static int fsp_page_reg_write(struct psmouse *psmouse, int reg_val)
>  {
> -	unsigned char	v;
> -#ifdef	FSP_DEBUG
> -	printk(KERN_INFO "fsp_page_reg_write: WRITE PAGE REG\n");
> -#endif
> -	if (fsp_ps2_command(psmouse, NULL, 0x00f3) < 0)
> -		return (-1);
> +	struct ps2dev *ps2dev = &psmouse->ps2dev;
> +	unsigned char v;
> +	int rc = -1;
> +
> +	mutex_lock(&ps2dev->cmd_mutex);
> +
> +	if (ps2_sendbyte(ps2dev, 0xf3, FSP_CMD_TIMEOUT) < 0)
> +		goto out;
> 
> -	fsp_ps2_command(psmouse, NULL, 0x0038);
> -	fsp_ps2_command(psmouse, NULL, 0x0088);
> +	ps2_sendbyte(ps2dev, 0x38, FSP_CMD_TIMEOUT2);
> +	ps2_sendbyte(ps2dev, 0x88, FSP_CMD_TIMEOUT2);
> 
> -	if (fsp_ps2_command(psmouse, NULL, 0x00f3) < 0)
> -		return (-1);
> +	if (ps2_sendbyte(ps2dev, 0xf3, FSP_CMD_TIMEOUT) < 0)
> +		return -1;
>
>  	if ((v = fsp_test_invert_cmd(reg_val)) != reg_val) {
> -		fsp_ps2_command(psmouse, NULL, 0x0047);
> +		ps2_sendbyte(ps2dev, 0x47, FSP_CMD_TIMEOUT2);
> +	} else if ((v = fsp_test_swap_cmd(reg_val)) != reg_val) {
> +		/* swapping is required */
> +		ps2_sendbyte(ps2dev, 0x44, FSP_CMD_TIMEOUT2);
>  	} else {
> -		if ((v = fsp_test_swap_cmd(reg_val)) != reg_val) {
> -			/* swapping is required */
> -			fsp_ps2_command(psmouse, NULL, 0x0044);
> -		} else {
> -			/* swapping isn't necessary */
> -			fsp_ps2_command(psmouse, NULL, 0x0033);
> -		}
> +		/* swapping isn't necessary */
> +		ps2_sendbyte(ps2dev, 0x33, FSP_CMD_TIMEOUT2);
>  	}
> -	fsp_ps2_command(psmouse, NULL, v);
> 
> -	return (0);
> +	ps2_sendbyte(ps2dev, v, FSP_CMD_TIMEOUT2);
> +	rc = 0;
> +
> + out:
> +	mutex_unlock(&ps2dev->cmd_mutex);
> +	dev_dbg(&ps2dev->serio->dev, "WRITE PAGE REG: to 0x%02x (rc = %d)\n",
> +		reg_val, rc);
> +	return rc;
>  }
> 
> -static int
> -fsp_batch_write_reg(struct psmouse *psmouse,
> -			const unsigned char *params, size_t size)
> +static int fsp_batch_write_reg(struct psmouse *psmouse,
> +				const unsigned char *params, size_t size)
>  {
> -	int	i, v;
> +	int i, v;
>
>  	if (size == 0)
> -		return (0);
> +		return 0;
>
>  	/* begin writing: enable register clock gating */
>  	fsp_reg_write_enable(psmouse, 1);
> 
> -	for (i = v = 0; i < size; i += 2) {
> +	for (i = v = 0; i < size; i += 2)
>  		if (fsp_reg_write(psmouse, params[i], params[i + 1]) != 0)
>  			v = -1;
> -	}
>
>  	/* complete writing: disable register clock gating */
>  	fsp_reg_write_enable(psmouse, 0);
> 
> -	return (v);
> +	return v;
>  }
> 
> -static int
> -fsp_device_id(struct psmouse *psmouse)
> +static int fsp_device_id(struct psmouse *psmouse)
>  {
>  	int	id;
>
>  	if (fsp_reg_read(psmouse, FSP_REG_DEVICE_ID, &id))
> -		return (-1);
> -	else
> -		return (id);
> +		return -1;
> +
> +	return id;
>  }
> 
> -static int
> -fsp_get_version(struct psmouse *psmouse)
> +static int fsp_get_version(struct psmouse *psmouse)
>  {
>  	int	ver;
>
>  	if (fsp_reg_read(psmouse, FSP_REG_VERSION, &ver))
> -		return (-1);
> -	else
> -		return (ver);
> +		return -1;
> +
> +	return ver;
>  }
> 
> -static int
> -fsp_get_revision(struct psmouse *psmouse)
> +static int fsp_get_revision(struct psmouse *psmouse)
>  {
>  	int	rev;
>
>  	if (fsp_reg_read(psmouse, FSP_REG_REVISION, &rev))
> -		return (-1);
> -	else
> -		return (rev);
> +		return -1;
> +
> +	return rev;
>  }
> 
> -static int
> -fsp_get_buttons(struct psmouse *psmouse)
> +static int fsp_get_buttons(struct psmouse *psmouse)
>  {
>  	int	buttons;
>
>  	if (fsp_reg_read(psmouse, FSP_REG_TMOD_STATUS1, &buttons) == -1)
> -		return (-1);
> +		return -1;
>
>  	switch (buttons & 0x30) {
>  	case 0x30:
>  	default:
>  		/* Left/Middle/Right */
> -		return (0x02);
> +		return 0x02;
>
>  	case 0x20:
>  		/* Left/Middle/Right & Scroll Up/Down */
> -		return (0x04);
> +		return 0x04;
>
>  	case 0x10:
>  		/* Left/Middle/Right & Scroll Up/Down/Right/Left */
> -		return (0x06);
> +		return 0x06;
>
>  	case 0x00:
>  		/* Left/Middle/Right/Forward/Backward & Scroll Up/Down */
> -		return (0x16);
> +		return 0x16;
>  	}
>  }
>
>  /** enable on-pad command tag output */
> -static int
> -fsp_opc_tag_enable(struct psmouse *psmouse, int en)
> +static int fsp_opc_tag_enable(struct psmouse *psmouse, int en)
>  {
> -	int	v, nv, res = 0;
> +	int v, nv;
> +	int res = 0;
>
>  	if (fsp_reg_read(psmouse, FSP_REG_OPC_QDOWN, &v) == -1) {
> -		printk(KERN_ERR "Unable get OPC state.\n");
> -		return (-1);
> +		dev_err(&psmouse->ps2dev.serio->dev, "Unable get OPC state.\n");
> +		return -1;
>  	}
> -	if (en) {
> +
> +	if (en)
>  		nv = v | FSP_BIT_EN_OPC_TAG;
> -	} else {
> +	else
>  		nv = v & ~(FSP_BIT_EN_OPC_TAG);
> -	}
> +
>  	/* only write if necessary */
>  	if (nv != v) {
>  		fsp_reg_write_enable(psmouse, 1);
>  		res = fsp_reg_write(psmouse, FSP_REG_OPC_QDOWN, nv);
>  		fsp_reg_write_enable(psmouse, 0);
>  	}
> -	if (res != 0) {
> -		printk(KERN_ERR "Unable to enable OPC tag.\n");
> -	}
> -	return (res);
> +
> +	if (res != 0)
> +		dev_err(&psmouse->ps2dev.serio->dev,
> +			"Unable to enable OPC tag.\n");
> +
> +	return res;
>  }
>
>  /**
>   * set packet format based on the number of buttons current device has
>   */
> -static int
> -fsp_set_packet_format(struct psmouse *psmouse)
> +static int fsp_set_packet_format(struct psmouse *psmouse)
>  {
>  	struct fsp_data	*ad = psmouse->private;
>  	struct ps2dev	*ps2dev = &psmouse->ps2dev;
> @@ -473,27 +426,33 @@ fsp_set_packet_format(struct psmouse *psmouse)
>  		ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
>  		ps2_command(ps2dev, param, PSMOUSE_CMD_GETID);
>  		if (param[0] != 0x04) {
> -			printk(KERN_ERR "Unable to enable 4 bytes packet.\n");
> +			dev_err(&psmouse->ps2dev.serio->dev,
> +				"Unable to enable 4 bytes packet.\n");
>  			psmouse->pktsize = 3;
> -			return (-1);
> +			return -1;
>  		}
>  		psmouse->pktsize = 4;
>  		break;
> +
>  	case 0x06:
>  		/* Left/Middle/Right & Scroll Up/Down/Right/Left */
>  		fsp_reg_read(psmouse, FSP_REG_SYSCTL5, &val);
>  		val &= ~(FSP_BIT_EN_MSID7 | FSP_BIT_EN_MSID8 | FSP_BIT_EN_AUTO_MSID8);
>  		val |= FSP_BIT_EN_MSID6;
>  		if (fsp_reg_write(psmouse, FSP_REG_SYSCTL5, val)) {
> -			printk(KERN_ERR "Unable to enable MSID6 mode.\n");
> -			return (-1);
> +			dev_err(&psmouse->ps2dev.serio->dev,
> +				"Unable to enable MSID6 mode.\n");
> +			return -1;
>  		}
>  		psmouse->pktsize = 4;
>  		break;
> +
>  	default:
> -		printk(KERN_ERR "Unknown number of buttons.\n");
> +		dev_err(&psmouse->ps2dev.serio->dev,
> +			"Unknown number of buttons.\n");
>  		break;
>  	}
> +
>  	/*
>  	 * enable OPC tags such that driver can tell the difference between
>  	 * on-pad and real button click
> @@ -504,26 +463,24 @@ fsp_set_packet_format(struct psmouse *psmouse)
>  /*
>   * return 0 if the pad is placed in 180 degree
>   */
> -int
> -fsp_get_degree(struct psmouse *psmouse)
> +static int fsp_get_degree(struct psmouse *psmouse)
>  {
>  	int	degree;
>
>  	if (fsp_reg_read(psmouse, FSP_REG_TMOD_STATUS1, &degree))
> -		return (-1);
> -	else
> -		return (degree & FSP_BIT_NO_ROTATION) ? 1 : 0;
> +		return -1;
> +
> +	return (degree & FSP_BIT_NO_ROTATION) ? 1 : 0;
>  }
> 
> -static int
> -fsp_onpad_vscr(struct psmouse *psmouse, int enable)
> +static int fsp_onpad_vscr(struct psmouse *psmouse, int enable)
>  {
>  	struct fsp_data		*ad = psmouse->private;
>  	struct fsp_hw_state	*state = &ad->hw_state;
>  	int			val;
>
>  	if (fsp_reg_read(psmouse, FSP_REG_ONPAD_CTL, &val))
> -		return (-1);
> +		return -1;
>
>  	state->onpad_vscroll = (enable == 0) ? 0 : 1;
> 
> @@ -533,23 +490,22 @@ fsp_onpad_vscr(struct psmouse *psmouse, int enable)
>  		val &= (0xff ^ FSP_BIT_FIX_VSCR);
>
>  	if (fsp_reg_write(psmouse, FSP_REG_ONPAD_CTL, val))
> -		return (-1);
> +		return -1;
> 
> -	return (0);
> +	return 0;
>  }
> 
> -static int
> -fsp_onpad_hscr(struct psmouse *psmouse, int enable)
> +static int fsp_onpad_hscr(struct psmouse *psmouse, int enable)
>  {
>  	struct fsp_data		*ad = psmouse->private;
>  	struct fsp_hw_state	*state = &ad->hw_state;
>  	int			val, v2;
>
>  	if (fsp_reg_read(psmouse, FSP_REG_ONPAD_CTL, &val))
> -		return (-1);
> +		return -1;
>
>  	if (fsp_reg_read(psmouse, FSP_REG_SYSCTL5, &v2))
> -		return (-1);
> +		return -1;
>
>  	state->onpad_hscroll = (enable == 0) ? 0 : 1;
> 
> @@ -562,17 +518,16 @@ fsp_onpad_hscr(struct psmouse *psmouse, int enable)
>  	}
>
>  	if (fsp_reg_write(psmouse, FSP_REG_ONPAD_CTL, val))
> -		return (-1);
> +		return -1;
>
>  	/* reconfigure horizontal scrolling packet output */
>  	if (fsp_reg_write(psmouse, FSP_REG_SYSCTL5, v2))
> -		return (-1);
> +		return -1;
> 
> -	return (0);
> +	return 0;
>  }
> 
> -static int
> -fsp_onpad_icon(struct psmouse *psmouse, int enable)
> +static int fsp_onpad_icon(struct psmouse *psmouse, int enable)
>  {
>  	struct fsp_data		*ad = psmouse->private;
>  	struct fsp_hw_state	*state = &ad->hw_state;
> @@ -583,7 +538,7 @@ fsp_onpad_icon(struct psmouse *psmouse, int enable)
>  	fsp_reg_read(psmouse, FSP_REG_PAGE_CTRL, &val);
>  	val |= 0x01;
>  	if (fsp_reg_write(psmouse, FSP_REG_PAGE_CTRL, val))
> -		return (-1);
> +		return -1;
>
>  	fsp_reg_write_enable(psmouse, 1);
>  	/* set position of icon switch button */
> @@ -603,13 +558,13 @@ fsp_onpad_icon(struct psmouse *psmouse, int enable)
>  		val = -1;
>  	fsp_reg_write_enable(psmouse, 0);
>  	if (val == -1)
> -		return (-1);
> +		return -1;
>
>  	/* switch back to register page 0 */
>  	fsp_reg_read(psmouse, FSP_REG_PAGE_CTRL, &val);
>  	val &= ~0x01;
>  	if (fsp_reg_write(psmouse, FSP_REG_PAGE_CTRL, val))
> -		return (-1);
> +		return -1;
>  #endif
>  	/* enable icon switch button and absolute packet */
>  	fsp_reg_read(psmouse, FSP_REG_SYSCTL5, &val);
> @@ -625,9 +580,9 @@ fsp_onpad_icon(struct psmouse *psmouse, int enable)
>  	}
>
>  	if (fsp_reg_write(psmouse, FSP_REG_SYSCTL5, val))
> -		return (-1);
> +		return -1;
> 
> -	return (0);
> +	return 0;
>  }
>
>  /*
> @@ -635,13 +590,12 @@ fsp_onpad_icon(struct psmouse *psmouse, int enable)
>   * in specified width; therefore, we ended up with rolling our own version
>   * of HEX string to integer helper.
>   */
> -static int
> -hexstr2int(const char *str, int width)
> +static int hexstr2int(const char *str, int width)
>  {
>  	int	i, val, res = 0;
>
>  	if (width > sizeof(int))
> -		return (res);
> +		return res;
>
>  	for (i = 0; i < width; i++) {
>  		const char	*ptr = &str[i];
> @@ -667,12 +621,11 @@ psmouse_attr_show_setreg(struct psmouse *psmouse, void *data, char *buf)
>   *
>   * ex: abcdc00d -- write 0xcd to register 0xab and 0x0d to 0xc0
>   */
> -static ssize_t
> -psmouse_attr_set_setreg(struct psmouse *psmouse, void *data,
> -				const char *buf, size_t count)
> +static ssize_t psmouse_attr_set_setreg(struct psmouse *psmouse, void *data,
> +					const char *buf, size_t count)
>  {
>  	struct fsp_data	*ad = psmouse->private;
> -	int		i, len, val;
> +	int i, len, val;
>
>  	if ((count % 4) != 0)
>  		return (-EINVAL);
> @@ -688,14 +641,14 @@ psmouse_attr_set_setreg(struct psmouse *psmouse, void *data,
>  	ad->init_params_len = len;
>  	fsp_batch_write_reg(psmouse, ad->init_params, len);
> 
> -	return (count);
> +	return count;
>  }
>
>  PSMOUSE_DEFINE_ATTR(setreg, S_IWUSR | S_IRUGO, NULL,
>  	psmouse_attr_show_setreg, psmouse_attr_set_setreg);
> 
> -static ssize_t
> -psmouse_attr_show_getreg(struct psmouse *psmouse, void *data, char *buf)
> +static ssize_t psmouse_attr_show_getreg(struct psmouse *psmouse,
> +					void *data, char *buf)
>  {
>  	struct fsp_data	*ad = psmouse->private;
> 
> @@ -708,9 +661,8 @@ psmouse_attr_show_getreg(struct psmouse *psmouse, void *data, char *buf)
>   *
>   * ex: ab -- read content from register 0xab
>   */
> -static ssize_t
> -psmouse_attr_set_getreg(struct psmouse *psmouse, void *data, const char *buf,
> -				size_t count)
> +static ssize_t psmouse_attr_set_getreg(struct psmouse *psmouse, void *data,
> +					const char *buf, size_t count)
>  {
>  	struct fsp_data	*ad = psmouse->private;
>  	int		reg, val;
> @@ -731,88 +683,84 @@ psmouse_attr_set_getreg(struct psmouse *psmouse, void *data, const char *buf,
>  PSMOUSE_DEFINE_ATTR(getreg, S_IWUSR | S_IRUGO, NULL,
>  	psmouse_attr_show_getreg, psmouse_attr_set_getreg);
> 
> -static ssize_t
> -psmouse_attr_show_pagereg(struct psmouse *psmouse, void *data, char *buf)
> +static ssize_t psmouse_attr_show_pagereg(struct psmouse *psmouse,
> +					 void *data, char *buf)
>  {
> -	int	val;
> +	int val;
>
>  	buf[0] = 0;
>
>  	if (fsp_page_reg_read(psmouse, &val))
> -		return (-ENODEV);
> +		return -ENODEV;
>
>  	return sprintf(buf, "%02x\n", val);
>  }
> 
> -static ssize_t
> -psmouse_attr_set_pagereg(struct psmouse *psmouse, void *data, const char *buf,
> -				size_t count)
> +static ssize_t psmouse_attr_set_pagereg(struct psmouse *psmouse, void *data,
> +					const char *buf, size_t count)
>  {
> -	int	val;
> +	int val;
>
>  	if (count != 2)
> -		return (-EINVAL);
> +		return -EINVAL;
>
>  	val = hexstr2int(buf, 2);
>
>  	if (fsp_page_reg_write(psmouse, val))
> -		return (-ENODEV);
> +		return -ENODEV;
> 
> -	return (count);
> +	return count;
>  }
>
>  PSMOUSE_DEFINE_ATTR(page, S_IWUSR | S_IRUGO, NULL,
>  	psmouse_attr_show_pagereg, psmouse_attr_set_pagereg);
> 
> -static ssize_t
> -psmouse_attr_show_ps2(struct psmouse *psmouse, void *data, char *buf)
> +static ssize_t psmouse_attr_show_ps2(struct psmouse *psmouse,
> +					void *data, char *buf)
>  {
>  	struct fsp_data	*ad = psmouse->private;
> -	char		tmp[2];
> -	int		i, len;
> +	char tmp[2];
> +	int i, len;
>
>  	for (i = len = 0; i < ad->resp_cnt; i++) {
>  		len += sprintf(tmp, "%02x", ad->resp[i]);
>  		strcat(buf, tmp);
>  	}
>  	strcat(buf, "\n");
> -	return (len + 1);
> +	return len + 1;
>  }
> 
> -static ssize_t
> -psmouse_attr_set_ps2(struct psmouse *psmouse, void *data, const char *buf,
> -			size_t count)
> +static ssize_t psmouse_attr_set_ps2(struct psmouse *psmouse, void *data,
> +					const char *buf, size_t count)
>  {
> -	struct fsp_data	*ad = psmouse->private;
> -	struct ps2dev	*ps2dev = &psmouse->ps2dev;
> -	int		v;
> +	struct fsp_data *ad = psmouse->private;
> +	struct ps2dev *ps2dev = &psmouse->ps2dev;
> +	int v;
>
>  	if (count != 4)
> -		return (-EINVAL);
> +		return -EINVAL;
>
>  	v = hexstr2int(buf, 4);
> 
> -	if (ps2_command(ps2dev, ad->resp, v) != -1) {
> +	if (ps2_command(ps2dev, ad->resp, v) != -1)
>  		ad->resp_cnt = (v >> 8) & (FSP_RESP_PKT_MAXLEN - 1);
> -	} else {
> +	else
>  		ad->resp_cnt = 0;
> -	}
> -	return (count);
> +
> +	return count;
>  }
>
>  PSMOUSE_DEFINE_ATTR(ps2, S_IWUSR | S_IRUGO, NULL,
>  	psmouse_attr_show_ps2, psmouse_attr_set_ps2);
> 
> -static ssize_t
> -psmouse_attr_show_vscroll(struct psmouse *psmouse, void *data, char *buf)
> +static ssize_t psmouse_attr_show_vscroll(struct psmouse *psmouse, void *data, char *buf)
>  {
>  	struct fsp_data	*ad = psmouse->private;
>
>  	return sprintf(buf, "%d\n", ad->hw_state.onpad_vscroll ? 1 : 0);
>  }
> 
> -static ssize_t
> -psmouse_attr_set_vscroll(struct psmouse *psmouse, void *data, const char *buf,
> +static ssize_t psmouse_attr_set_vscroll(struct psmouse *psmouse, void *data, const char *buf,
>  				size_t count)
>  {
>  	struct fsp_data	*ad = psmouse->private;
> @@ -821,28 +769,26 @@ psmouse_attr_set_vscroll(struct psmouse *psmouse, void *data, const char *buf,
>
>  	val = simple_strtoul(buf, &rest, 10);
> 
> -	if (*rest || (val > 1))
> -		return (-EINVAL);
> +	if (*rest || val > 1)
> +		return -EINVAL;
>
>  	ad->hw_state.onpad_vscroll = val;
>  	fsp_onpad_vscr(psmouse, val);
> 
> -	return (count);
> +	return count;
>  }
>
>  PSMOUSE_DEFINE_ATTR(vscroll, S_IWUSR | S_IRUGO | S_IWUGO, NULL,
>  	psmouse_attr_show_vscroll, psmouse_attr_set_vscroll);
> 
> -static ssize_t
> -psmouse_attr_show_hscroll(struct psmouse *psmouse, void *data, char *buf)
> +static ssize_t psmouse_attr_show_hscroll(struct psmouse *psmouse, void *data, char *buf)
>  {
>  	struct fsp_data	*ad = psmouse->private;
>
>  	return sprintf(buf, "%d\n", ad->hw_state.onpad_hscroll ? 1 : 0);
>  }
> 
> -static ssize_t
> -psmouse_attr_set_hscroll(struct psmouse *psmouse, void *data, const char *buf,
> +static ssize_t psmouse_attr_set_hscroll(struct psmouse *psmouse, void *data, const char *buf,
>  				size_t count)
>  {
>  	struct fsp_data	*ad = psmouse->private;
> @@ -863,16 +809,14 @@ psmouse_attr_set_hscroll(struct psmouse *psmouse, void *data, const char *buf,
>  PSMOUSE_DEFINE_ATTR(hscroll, S_IWUSR | S_IRUGO | S_IWUGO, NULL,
>  	psmouse_attr_show_hscroll, psmouse_attr_set_hscroll);
> 
> -static ssize_t
> -psmouse_attr_show_onpadicon(struct psmouse *psmouse, void *data, char *buf)
> +static ssize_t psmouse_attr_show_onpadicon(struct psmouse *psmouse, void *data, char *buf)
>  {
>  	struct fsp_data	*ad = psmouse->private;
>
>  	return sprintf(buf, "%d\n", ad->hw_state.onpad_icon ? 1 : 0);
>  }
> 
> -static ssize_t
> -psmouse_attr_set_onpadicon(struct psmouse *psmouse, void *data,
> +static ssize_t psmouse_attr_set_onpadicon(struct psmouse *psmouse, void *data,
>  				const char *buf, size_t count)
>  {
>  	struct fsp_data	*ad = psmouse->private;
> @@ -893,16 +837,14 @@ psmouse_attr_set_onpadicon(struct psmouse *psmouse, void *data,
>  PSMOUSE_DEFINE_ATTR(onpadicon, S_IWUSR | S_IRUGO | S_IWUGO, NULL,
>  	psmouse_attr_show_onpadicon, psmouse_attr_set_onpadicon);
> 
> -static ssize_t
> -psmouse_attr_show_pktfmt(struct psmouse *psmouse, void *data, char *buf)
> +static ssize_t psmouse_attr_show_pktfmt(struct psmouse *psmouse, void *data, char *buf)
>  {
>  	struct fsp_data	*ad = psmouse->private;
>
>  	return sprintf(buf, "%d\n", ad->hw_state.pkt_fmt);
>  }
> 
> -static ssize_t
> -psmouse_attr_set_pktfmt(struct psmouse *psmouse, void *data,
> +static ssize_t psmouse_attr_set_pktfmt(struct psmouse *psmouse, void *data,
>  				const char *buf, size_t count)
>  {
>  	struct fsp_data	*ad = psmouse->private;
> @@ -923,8 +865,7 @@ psmouse_attr_set_pktfmt(struct psmouse *psmouse, void *data,
>  PSMOUSE_DEFINE_ATTR(pktfmt, S_IWUSR | S_IRUGO | S_IWUGO, NULL,
>  	psmouse_attr_show_pktfmt, psmouse_attr_set_pktfmt);
> 
> -static ssize_t
> -psmouse_attr_show_flags(struct psmouse *psmouse, void *data, char *buf)
> +static ssize_t psmouse_attr_show_flags(struct psmouse *psmouse, void *data, char *buf)
>  {
>  	struct fsp_data	*ad = psmouse->private;
> 
> @@ -937,8 +878,7 @@ psmouse_attr_show_flags(struct psmouse *psmouse, void *data, char *buf)
>  		ad->flags & FSPDRV_FLAG_EN_OPC ? 'C' : 'c');
>  }
> 
> -static ssize_t
> -psmouse_attr_set_flags(struct psmouse *psmouse, void *data,
> +static ssize_t psmouse_attr_set_flags(struct psmouse *psmouse, void *data,
>  				const char *buf, size_t count)
>  {
>  	struct fsp_data	*ad = psmouse->private;
> @@ -1004,35 +944,16 @@ psmouse_attr_set_flags(struct psmouse *psmouse, void *data,
>  			fsp_set_packet_format(psmouse);
>  			break;
>  		default:
> -			return (-EINVAL);
> +			return -EINVAL;
>  		}
>  	}
> -	return (count);
> +	return count;
>  }
>
>  PSMOUSE_DEFINE_ATTR(flags, S_IWUSR | S_IRUGO | S_IWUGO, NULL,
>  	psmouse_attr_show_flags, psmouse_attr_set_flags);
> 
> -static ssize_t
> -psmouse_attr_show_ver(struct psmouse *psmouse, void *data, char *buf)
> -{
> -	return sprintf(buf, "Sentelic FSP kernel module %d.%d.%d\n",
> -		fsp_drv_ver[0], fsp_drv_ver[1], fsp_drv_ver[2]);
> -}
> -
> -static ssize_t
> -psmouse_attr_set_ver(struct psmouse *psmouse, void *data,
> -				const char *buf, size_t count)
> -{
> -	/* do nothing */
> -	return (count);
> -}
> -
> -PSMOUSE_DEFINE_ATTR(ver, S_IRUSR | S_IRUGO, NULL,
> -	psmouse_attr_show_ver, psmouse_attr_set_ver);
> -
> -static ssize_t
> -psmouse_attr_show_accel(struct psmouse *psmouse, void *data, char *buf)
> +static ssize_t psmouse_attr_show_accel(struct psmouse *psmouse, void *data, char *buf)
>  {
>  	struct fsp_data	*ad = psmouse->private;
> 
> @@ -1040,8 +961,7 @@ psmouse_attr_show_accel(struct psmouse *psmouse, void *data, char *buf)
>  		ad->accel_num, ad->accel_denom, ad->accel_threshold);
>  }
> 
> -static ssize_t
> -psmouse_attr_set_accel(struct psmouse *psmouse, void *data,
> +static ssize_t psmouse_attr_set_accel(struct psmouse *psmouse, void *data,
>  				const char *buf, size_t count)
>  {
>  	struct fsp_data	*ad = psmouse->private;
> @@ -1066,167 +986,98 @@ psmouse_attr_set_accel(struct psmouse *psmouse, void *data,
>  PSMOUSE_DEFINE_ATTR(accel, S_IWUSR | S_IRUGO | S_IWUGO, NULL,
>  	psmouse_attr_show_accel, psmouse_attr_set_accel);
> 
> -int
> -fsp_reset(struct psmouse *psmouse)
> +int fsp_reset(struct psmouse *psmouse)
>  {
>  	/* TODO: reset initial parameters */
> -	return (0);
> +	return 0;
>  }
> 
> -static int
> -fsp_reconnect(struct psmouse *psmouse)
> +static int fsp_reconnect(struct psmouse *psmouse)
>  {
> -	int		version;
> +	int version;
>
>  	if (fsp_detect(psmouse, 0) < 0)
> -		return (-1);
> +		return -1;
>
>  	if ((version = fsp_get_version(psmouse)) < 0)
> -		return (-1);
> +		return -1;
>
>  	fsp_reset(psmouse);
> 
> -	return (0);
> -}
> -
> -static void
> -fsp_remove_sysfs(struct psmouse *psmouse)
> -{
> -	device_remove_file(&psmouse->ps2dev.serio->dev,
> -				&psmouse_attr_setreg.dattr);
> -	device_remove_file(&psmouse->ps2dev.serio->dev,
> -				&psmouse_attr_getreg.dattr);
> -	device_remove_file(&psmouse->ps2dev.serio->dev,
> -				&psmouse_attr_page.dattr);
> -	device_remove_file(&psmouse->ps2dev.serio->dev,
> -				&psmouse_attr_ps2.dattr);
> -	device_remove_file(&psmouse->ps2dev.serio->dev,
> -				&psmouse_attr_vscroll.dattr);
> -	device_remove_file(&psmouse->ps2dev.serio->dev,
> -				&psmouse_attr_hscroll.dattr);
> -	device_remove_file(&psmouse->ps2dev.serio->dev,
> -				&psmouse_attr_onpadicon.dattr);
> -	device_remove_file(&psmouse->ps2dev.serio->dev,
> -				&psmouse_attr_pktfmt.dattr);
> -	device_remove_file(&psmouse->ps2dev.serio->dev,
> -				&psmouse_attr_flags.dattr);
> -	device_remove_file(&psmouse->ps2dev.serio->dev,
> -				&psmouse_attr_ver.dattr);
> -	device_remove_file(&psmouse->ps2dev.serio->dev,
> -				&psmouse_attr_accel.dattr);
> +	return 0;
>  }
> 
> -static void
> -fsp_disconnect(struct psmouse *psmouse)
> +static struct attribute *fsp_attributes[] = {
> +	&psmouse_attr_setreg.dattr.attr,
> +	&psmouse_attr_getreg.dattr.attr,
> +	&psmouse_attr_page.dattr.attr,
> +	&psmouse_attr_ps2.dattr.attr,
> +	&psmouse_attr_vscroll.dattr.attr,
> +	&psmouse_attr_hscroll.dattr.attr,
> +	&psmouse_attr_accel.dattr.attr,
> +	NULL
> +};
> +
> +static struct attribute_group fsp_attribute_group = {
> +	.attrs	= fsp_attributes,
> +};
> +
> +static void fsp_disconnect(struct psmouse *psmouse)
>  {
> -	fsp_remove_sysfs(psmouse);
> +	sysfs_remove_group(&psmouse->ps2dev.serio->dev.kobj,
> +			   &fsp_attribute_group);
>  	fsp_opc_tag_enable(psmouse, 0);
>  	fsp_reset(psmouse);
>  	kfree(psmouse->private);
>  }
> 
> -int
> -fsp_detect(struct psmouse *psmouse, int set_properties)
> +int fsp_detect(struct psmouse *psmouse, int set_properties)
>  {
> -	int	rc;
> +	int	error;
>
>  	if (fsp_device_id(psmouse) != 0x01)
> -		return (-1);
> +		return -1;
>
>  	if (set_properties) {
>  		psmouse->vendor = "Sentelic";
>  		psmouse->name = "FingerSensingPad";
> 
> -		/*
> -		 * register sysfs callbacks for userland program to set
> -		 * initial parameters
> -		 */
> -		rc = device_create_file(&psmouse->ps2dev.serio->dev,
> -					&psmouse_attr_setreg.dattr);
> -		if (rc)
> -			goto sysfs_creation_failed;
> -
> -		rc = device_create_file(&psmouse->ps2dev.serio->dev,
> -					&psmouse_attr_getreg.dattr);
> -		if (rc)
> -			goto sysfs_creation_failed;
> -
> -		rc = device_create_file(&psmouse->ps2dev.serio->dev,
> -					&psmouse_attr_page.dattr);
> -		if (rc)
> -			goto sysfs_creation_failed;
> -
> -		rc = device_create_file(&psmouse->ps2dev.serio->dev,
> -					&psmouse_attr_ps2.dattr);
> -		if (rc)
> -			goto sysfs_creation_failed;
> -
> -		rc = device_create_file(&psmouse->ps2dev.serio->dev,
> -					&psmouse_attr_vscroll.dattr);
> -		if (rc)
> -			goto sysfs_creation_failed;
> -
> -		rc = device_create_file(&psmouse->ps2dev.serio->dev,
> -					&psmouse_attr_hscroll.dattr);
> -		if (rc)
> -			goto sysfs_creation_failed;
> -
> -		rc = device_create_file(&psmouse->ps2dev.serio->dev,
> -					&psmouse_attr_onpadicon.dattr);
> -		if (rc)
> -			goto sysfs_creation_failed;
> -
> -		rc = device_create_file(&psmouse->ps2dev.serio->dev,
> -					&psmouse_attr_pktfmt.dattr);
> -		if (rc)
> -			goto sysfs_creation_failed;
> -
> -		rc = device_create_file(&psmouse->ps2dev.serio->dev,
> -					&psmouse_attr_flags.dattr);
> -		if (rc)
> -			goto sysfs_creation_failed;
> -
> -		rc = device_create_file(&psmouse->ps2dev.serio->dev,
> -					&psmouse_attr_ver.dattr);
> -		if (rc)
> -			goto sysfs_creation_failed;
> -
> -		rc = device_create_file(&psmouse->ps2dev.serio->dev,
> -					&psmouse_attr_accel.dattr);
> -		if (rc)
> -			goto sysfs_creation_failed;
> +		error = sysfs_create_group(&psmouse->ps2dev.serio->dev.kobj,
> +					   &fsp_attribute_group);
> +		if (error) {
> +			dev_err(&psmouse->ps2dev.serio->dev,
> +				"Failed to create sysfs attributes (%d)",
> +				error);
> +			return -1;
> +		}
>  	}
> -	return (0);
> -sysfs_creation_failed:
> -	fsp_remove_sysfs(psmouse);
> -	printk(KERN_ERR "failed to create sysfs node(%d)", rc);
> -	return (-1);
> +
> +	return 0;
>  }
> 
> -static void
> -fsp_set_input_params(struct psmouse *psmouse)
> +static void fsp_set_input_params(struct psmouse *psmouse)
>  {
>  	struct fsp_data		*ad = psmouse->private;
>  	struct fsp_hw_state	*state = &ad->hw_state;
>
>  	if (state->abs_pkt == 0) {
> -		set_bit(BTN_MIDDLE, psmouse->dev->keybit);
> -		set_bit(REL_WHEEL, psmouse->dev->relbit);
> -		set_bit(REL_HWHEEL, psmouse->dev->relbit);
> +		__set_bit(BTN_MIDDLE, psmouse->dev->keybit);
> +		__set_bit(REL_WHEEL, psmouse->dev->relbit);
> +		__set_bit(REL_HWHEEL, psmouse->dev->relbit);
> 
> -		set_bit(EV_REL, psmouse->dev->evbit);
> -		set_bit(REL_X, psmouse->dev->relbit);
> -		set_bit(REL_Y, psmouse->dev->relbit);
> +		__set_bit(EV_REL, psmouse->dev->evbit);
> +		__set_bit(REL_X, psmouse->dev->relbit);
> +		__set_bit(REL_Y, psmouse->dev->relbit);
> 
> -		set_bit(BTN_BACK, psmouse->dev->keybit);
> -		set_bit(BTN_FORWARD, psmouse->dev->keybit);
> +		__set_bit(BTN_BACK, psmouse->dev->keybit);
> +		__set_bit(BTN_FORWARD, psmouse->dev->keybit);
> 
> -		clear_bit(EV_ABS, psmouse->dev->evbit);
> -		clear_bit(BTN_SIDE, psmouse->dev->keybit);
> -		clear_bit(BTN_EXTRA, psmouse->dev->keybit);
> +		__clear_bit(EV_ABS, psmouse->dev->evbit);
> +		__clear_bit(BTN_SIDE, psmouse->dev->keybit);
> +		__clear_bit(BTN_EXTRA, psmouse->dev->keybit);
>  	} else {
>  		/* enable absolute packet mode */
> -		set_bit(EV_ABS, psmouse->dev->evbit);
> +		__set_bit(EV_ABS, psmouse->dev->evbit);
>
>  		input_set_abs_params(psmouse->dev, ABS_X,
>  			0, 1023, 0, 0);
> @@ -1240,12 +1091,7 @@ fsp_set_input_params(struct psmouse *psmouse)
>  	}
>  }
> 
> -static psmouse_ret_t
> -fsp_process_byte(struct psmouse *psmouse
> -#if	LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
> -, struct pt_regs *regs
> -#endif
> -)
> +static psmouse_ret_t fsp_process_byte(struct psmouse *psmouse)
>  {
>  	struct input_dev	*dev = psmouse->dev;
>  	struct fsp_data		*ad = psmouse->private;
> @@ -1259,17 +1105,7 @@ fsp_process_byte(struct psmouse *psmouse
>  	int			rel_x, rel_y;
>
>  	if (psmouse->pktcnt < 4)
> -		return (PSMOUSE_GOOD_DATA);
> -
> -	if (psmouse->ps2dev.flags != 0) {
> -		/*
> -		 * XXX need to find the root cause that makes commanding
> -		 * packet leaking to this function.
> -		 *
> -		 * Perhaps our own version of ps2_command() is out of date?
> -		 */
> -		return (PSMOUSE_GOOD_DATA);
> -	}
> +		return PSMOUSE_GOOD_DATA;
>
>  	/*
>  	 * Full packet accumulated, process it
> @@ -1290,6 +1126,7 @@ fsp_process_byte(struct psmouse *psmouse
>  			prev_abs_x = abs_x;
>  			prev_abs_y = abs_y;
>  		}
> +
>  		if (ad->flags & (FSPDRV_FLAG_OPICON_BTN | FSPDRV_FLAG_OPICON_KEY)) {
>  			/* do nothing */
>  		} else {
> @@ -1310,28 +1147,24 @@ fsp_process_byte(struct psmouse *psmouse
>  		input_report_abs(dev, ABS_X, prev_abs_x);
>  		input_report_abs(dev, ABS_Y, prev_abs_y);
>  		break;
> +
>  	case FSP_PKT_TYPE_NORMAL_OPC:
>  		/* on-pad click, filter it if necessary */
> -		if ((ad->flags & FSPDRV_FLAG_EN_OPC) != FSPDRV_FLAG_EN_OPC) {
> +		if ((ad->flags & FSPDRV_FLAG_EN_OPC) != FSPDRV_FLAG_EN_OPC)
>  			packet[0] &= ~BIT(0);
> -		}
>  		/* fall through */
>  	case FSP_PKT_TYPE_NORMAL:
>  		/* normal packet */
>  		/* special packet data translation from on-pad packets */
>  		if (packet[3] != 0) {
> -			if (packet[3] & BIT(0)) {
> +			if (packet[3] & BIT(0))
>  				button_status |= 0x01;	/* wheel down */
> -			}
> -			if (packet[3] & BIT(1)) {
> +			if (packet[3] & BIT(1))
>  				button_status |= 0x0f;	/* wheel up */
> -			}
> -			if (packet[3] & BIT(2)) {
> +			if (packet[3] & BIT(2))
>  				button_status |= BIT(5);/* horizontal left */
> -			}
> -			if (packet[3] & BIT(3)) {
> +			if (packet[3] & BIT(3))
>  				button_status |= BIT(4);/* horizontal right */
> -			}
>  			/* push back to packet queue */
>  			if (button_status != 0)
>  				packet[3] = button_status;
> @@ -1341,7 +1174,8 @@ fsp_process_byte(struct psmouse *psmouse
>  		/*
>  		 * Processing wheel up/down and extra button events
>  		 */
> -		input_report_rel(dev, REL_WHEEL, (int)(packet[3] & 8) - (int)(packet[3] & 7));
> +		input_report_rel(dev, REL_WHEEL,
> +				 (int)(packet[3] & 8) - (int)(packet[3] & 7));
>  		input_report_rel(dev, REL_HWHEEL, lscroll - rscroll);
>  		input_report_key(dev, BTN_BACK, lscroll);
>  		input_report_key(dev, BTN_FORWARD, rscroll);
> @@ -1357,12 +1191,10 @@ fsp_process_byte(struct psmouse *psmouse
>  		rel_x = packet[1] ? (int)packet[1] - (int)((packet[0] << 4) & 0x100) : 0;
>  		rel_y = packet[2] ? (int)((packet[0] << 3) & 0x100) - (int)packet[2] : 0;
> 
> -		if (abs(rel_x) > ad->accel_threshold) {
> +		if (abs(rel_x) > ad->accel_threshold)
>  			rel_x = rel_x * ad->accel_num / ad->accel_denom;
> -		}
> -		if (abs(rel_y) > ad->accel_threshold) {
> +		if (abs(rel_y) > ad->accel_threshold)
>  			rel_y = rel_y * ad->accel_num / ad->accel_denom;
> -		}
>  		input_report_rel(dev, REL_X, rel_x);
>  		input_report_rel(dev, REL_Y, rel_y);
>  		break;
> @@ -1381,20 +1213,20 @@ fsp_process_byte(struct psmouse *psmouse
>  		ps2_last_second = jiffies_msec;
>  	}
>  #endif
> -	return (PSMOUSE_FULL_PACKET);
> +	return PSMOUSE_FULL_PACKET;
>  }
> 
> -int
> -fsp_init(struct psmouse *psmouse)
> +int fsp_init(struct psmouse *psmouse)
>  {
>  	struct fsp_data	*priv;
> -	int		ver;
> +	int ver;
>
>  	if ((ver = fsp_get_version(psmouse)) < 0)
> -		return (-1);
> +		return -1;
> 
> -	if (!(priv = kzalloc(sizeof(struct fsp_data), GFP_KERNEL)))
> -		return (-ENOMEM);
> +	priv = kzalloc(sizeof(struct fsp_data), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
>
>  	psmouse->private = priv;
> 
> @@ -1424,7 +1256,8 @@ fsp_init(struct psmouse *psmouse)
>  	psmouse->reconnect = fsp_reconnect;
>
>  	/* report hardware information */
> -	printk(KERN_INFO "Finger Sensing Pad, hw: %d.%d.%d, sw: %d.%d.%d, buttons: %d\n",
> +	printk(KERN_INFO "Finger Sensing Pad, "
> +		"hw: %d.%d.%d, sw: %d.%d.%d, buttons: %d\n",
>  		(priv->ver >> 4), (priv->ver & 0x0F), priv->rev,
>  		fsp_drv_ver[0], fsp_drv_ver[1], fsp_drv_ver[2],
>  		priv->buttons & 7);
> @@ -1449,5 +1282,5 @@ fsp_init(struct psmouse *psmouse)
>  	/* set various supported input event bits */
>  	fsp_set_input_params(psmouse);
> 
> -	return (0);
> +	return 0;
>  }
> diff --git a/drivers/input/mouse/sentelic.h b/drivers/input/mouse/sentelic.h
> index 8fcaa40..30dae3b 100644
> --- a/drivers/input/mouse/sentelic.h
> +++ b/drivers/input/mouse/sentelic.h
> @@ -17,18 +17,10 @@
>   *   You should have received a copy of the GNU General Public License
>   *   along with this program; if not, write to the Free Software
>   *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> - *
> - * $Id: sentelic.h 28700 2008-10-16 07:23:43Z avatar $
>   */
> 
> -#ifndef	__SENTELIC_H__
> -#define	__SENTELIC_H__
> -
> -#if	defined(__KERNEL__)
> -extern int fsp_detect(struct psmouse *psmouse, int set_properties);
> -extern int fsp_init(struct psmouse *psmouse);
> -extern int fsp_reset(struct psmouse *psmouse);
> -#endif
> +#ifndef	__SENTELIC_H
> +#define	__SENTELIC_H
>
>  /* Finger-sensing Pad information registers */
>  #define	FSP_REG_DEVICE_ID	0x00
> @@ -71,8 +63,7 @@ extern int fsp_reset(struct psmouse *psmouse);
>  #define	FSP_PKT_TYPE_NORMAL_OPC	(0x03)
>  #define	FSP_PKT_TYPE_SHIFT	(6)
> 
> -struct fsp_hw_state
> -{
> +struct fsp_hw_state {
>  	unsigned char	onpad_vscroll:1,/* On-pad vertical scroll zone */
>  			onpad_hscroll:1,/* On-pad horizontal scroll zone */
>  			onpad_icon:1,	/* On-pad icons */
> @@ -83,8 +74,7 @@ struct fsp_hw_state
>  	unsigned int	reg_val;	/* used by reg_write sysctl */
>  };
> 
> -struct fsp_data
> -{
> +struct fsp_data {
>  	unsigned int		flags;
>  #define FSPDRV_FLAG_CMD		(0x010)	/* The command bit of flags indicates the special FSP PS/2 command is sent. */
>  #define FSPDRV_FLAG_RESP	(0x020)	/* The response bit of flags indicates the special FSP PS/2 comamnd is sent and response is received. */
> @@ -95,8 +85,8 @@ struct fsp_data
>  #define	FSPDRV_FLAG_AUTO_SWITCH	(0x400)	/* software on-pad icon auto switch */
>  #define	FSPDRV_FLAG_EN_OPC	(0x800)	/* enable on-pad clicking */
>  #define FSP_RESP_PKT_MAXLEN	(8)	/* The max response packet size. */
> -	unsigned char 		cmd;	/* The buffer used to store the sending PS/2 command */
> -	unsigned char 		resp[FSP_RESP_PKT_MAXLEN]; /* The buffer used to store the response of PS/2 command */
> +	unsigned char		cmd;	/* The buffer used to store the sending PS/2 command */
> +	unsigned char		resp[FSP_RESP_PKT_MAXLEN]; /* The buffer used to store the response of PS/2 command */
>  	int			resp_cnt;	/* The command count in resp buffer */
>  	unsigned char		buttons;	/* Number of buttons */
>  	unsigned char		ver;		/* hardware version */
> @@ -133,4 +123,19 @@ struct fsp_data
>  	struct fsp_hw_state	hw_state;
>  };
> 
> -#endif	/* !__SENTELIC_H__ */
> +#ifdef CONFIG_MOUSE_PS2_SENTELIC
> +extern int fsp_detect(struct psmouse *psmouse, int set_properties);
> +extern int fsp_init(struct psmouse *psmouse);
> +/*extern int fsp_reset(struct psmouse *psmouse);*/
> +#else
> +inline int fsp_detect(struct psmouse *psmouse, int set_properties)
> +{
> +	return -ENOSYS;
> +}
> +inline int fsp_init(struct psmouse *psmouse)
> +{
> +	return -ENOSYS;
> +}
> +#endif
> +
> +#endif	/* __SENTELIC_H */
> diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
> index 2b304c2..e6852b8 100644
> --- a/drivers/input/serio/libps2.c
> +++ b/drivers/input/serio/libps2.c
> @@ -161,7 +161,7 @@ static int ps2_adjust_timeout(struct ps2dev *ps2dev, int command, int timeout)
>   * ps2_command() can only be called from a process context
>   */
> 
> -int ps2_command(struct ps2dev *ps2dev, unsigned char *param, int command)
> +int __ps2_command(struct ps2dev *ps2dev, unsigned char *param, int command)
>  {
>  	int timeout;
>  	int send = (command >> 12) & 0xf;
> @@ -179,8 +179,6 @@ int ps2_command(struct ps2dev *ps2dev, unsigned char *param, int command)
>  		return -1;
>  	}
> 
> -	mutex_lock(&ps2dev->cmd_mutex);
> -
>  	serio_pause_rx(ps2dev->serio);
>  	ps2dev->flags = command == PS2_CMD_GETID ? PS2_FLAG_WAITID : 0;
>  	ps2dev->cmdcnt = receive;
> @@ -231,7 +229,18 @@ int ps2_command(struct ps2dev *ps2dev, unsigned char *param, int command)
>  	ps2dev->flags = 0;
>  	serio_continue_rx(ps2dev->serio);
> 
> +	return rc;
> +}
> +EXPORT_SYMBOL(__ps2_command);
> +
> +int ps2_command(struct ps2dev *ps2dev, unsigned char *param, int command)
> +{
> +	int rc;
> +
> +	mutex_lock(&ps2dev->cmd_mutex);
> +	rc = __ps2_command(ps2dev, param, command);
>  	mutex_unlock(&ps2dev->cmd_mutex);
> +
>  	return rc;
>  }
>  EXPORT_SYMBOL(ps2_command);
> diff --git a/include/linux/libps2.h b/include/linux/libps2.h
> index afc4133..06ef5d8 100644
> --- a/include/linux/libps2.h
> +++ b/include/linux/libps2.h
> @@ -42,6 +42,7 @@ struct ps2dev {
>  void ps2_init(struct ps2dev *ps2dev, struct serio *serio);
>  int ps2_sendbyte(struct ps2dev *ps2dev, unsigned char byte, int timeout);
>  void ps2_drain(struct ps2dev *ps2dev, int maxbytes, int timeout);
> +int __ps2_command(struct ps2dev *ps2dev, unsigned char *param, int command);
>  int ps2_command(struct ps2dev *ps2dev, unsigned char *param, int command);
>  int ps2_handle_ack(struct ps2dev *ps2dev, unsigned char data);
>  int ps2_handle_response(struct ps2dev *ps2dev, unsigned char data);
