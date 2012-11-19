From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input: Cypress PS/2 Trackpad link into psmouse-base
Date: Mon, 19 Nov 2012 15:48:01 -0800
Message-ID: <20121119234801.GB21922@core.coreip.homeip.net>
References: <1353367837-18229-1-git-send-email-kamal@canonical.com>
 <1353367837-18229-3-git-send-email-kamal@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1353367837-18229-3-git-send-email-kamal@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kamal Mostafa <kamal@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, David Solda <dso@cypress.com>, Troy Abercrombia <ta@cypress.com>, Cypress Semiconductor Corporation <customercare@cypress.com>, Kyle Fazzari <git@status.e4ward.com>, Mario Limonciello <mario_limonciello@dell.com>, Tim Gardner <tim.gardner@canonical.com>, Herton Krzesinski <herton.krzesinski@canonical.com>
List-Id: linux-input@vger.kernel.org

Hi Kamal,

On Mon, Nov 19, 2012 at 03:30:37PM -0800, Kamal Mostafa wrote:
> @@ -321,6 +323,13 @@ static irqreturn_t psmouse_interrupt(struct serio *serio,
>  	if (psmouse->state <= PSMOUSE_RESYNCING)
>  		goto out;
>  
> +	/* For Cypress Trackpad to read some special data more than 6 bytes. */
> +	if (psmouse->state == PSMOUSE_CMD_CYTP) {
> +		psmouse->packet[psmouse->pktcnt++] = data;
> +		wake_up(&psmouse->ps2dev.wait);
> +		goto out;
> +	}

Instead of doing this have you tried extending size of cmdbuf in ps2dev
structure to 8?

Thanks.

-- 
Dmitry
