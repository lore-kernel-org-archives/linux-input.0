From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH v2] input: add synaptics_i2c driver
Date: Wed, 20 May 2009 14:49:49 +0200
Message-ID: <20090520144949.15fa457b@hyperion.delvare>
References: <4A13F941.7040301@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:32761 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756773AbZETMuB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 May 2009 08:50:01 -0400
In-Reply-To: <4A13F941.7040301@compulab.co.il>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, grinberg <grinberg@compulab.co.il>, linux-input <linux-input@vger.kernel.org>

On Wed, 20 May 2009 15:36:17 +0300, Mike Rapoport wrote:
> This patch adds support for Synaptics i2c touchpad controller found on
> eXeda machine.
> 
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> CC: Jean Delvare <khali@linux-fr.org>
> 
> ---
> v2 changelog:
>   - fix bugs and issues pointed out by Jean and Dmitry
>   - use workqueue instead of kthread
>   - reorganize methods order to something more logical
> 
> ---
>  drivers/input/mouse/Kconfig         |   18 +
>  drivers/input/mouse/Makefile        |    1 +
>  drivers/input/mouse/synaptics_i2c.c |  700 +++++++++++++++++++++++++++++++++++
>  3 files changed, 719 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/mouse/synaptics_i2c.c

(I2C parts:)
Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare
