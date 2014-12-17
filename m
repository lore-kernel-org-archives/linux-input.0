From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v16 01/12] input: cyapa: re-design driver to support
Date: Wed, 17 Dec 2014 02:14:34 -0800
Message-ID: <20141217101434.GA2155@newt.localdomain>
References: <BAY407-EAS4239EB7A931AAE7C4C747F3BD6D0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:52606 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbaLQKOj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Dec 2014 05:14:39 -0500
Content-Disposition: inline
In-Reply-To: <BAY407-EAS4239EB7A931AAE7C4C747F3BD6D0@phx.gbl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dudley Du <dudlx@outlook.com>
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, bleung@google.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Dudley,

On Wed, Dec 17, 2014 at 05:55:37PM +0800, Dudley Du wrote:
> In order to support multiple different chipsets and communication protocols
> trackpad devices in one cyapa driver, the new cyapa driver is re-designed
> with one cyapa driver core and multiple device specific functions component.
> The cyapa driver core is contained in this patch, it supplies basic functions
[...]
> +
> +	.set_power_mode = cyapa_gen3_set_power_mode,
> +};
> -- 
> 1.9.1
> 

Unfortunately this patch and the others do not apply.

  Patch failed at 0001 input: cyapa: re-design driver to support
  The copy of the patch that failed is found in:
     /home/jeri/linux-next/.git/rebase-apply/patch
  When you have resolved this problem, run "git am --continue".
  If you prefer to skip this patch, run "git am --skip" instead.
  To restore the original branch and stop patching, run "git am
  --abort".

It looks like your mailer may have done some line wrapping that
messed up the patches.

  ...
  -       { CYAPA_SMBUS_BLK_HEAD, 16 },
  -};
  +static int cyapa_reinitialize(struct cyapa *cyapa);
   
  -static ssize_t cyapa_i2c_reg_read_block(struct cyapa *cyapa, u8 reg,
  size_t
  len,
  +/* Returns 0 on success, else negative errno on failure. */
  +static ssize_t cyapa_i2c_read(struct cyapa *cyapa, u8 reg, size_t len,
                                          u8 *values)
   {
  -     
  ...

linux/Documentation/email-clients.txt has good information about these
problems.

-- 
- Jeremiah Mahler
