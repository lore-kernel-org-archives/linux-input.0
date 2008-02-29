From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] [repost] Make real parent for ACPI button input devices
Date: Thu, 28 Feb 2008 17:27:24 -0800
Message-ID: <20080228172724.e93f6b8d.akpm@linux-foundation.org>
References: <200802282114.28680.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([207.189.120.13]:39887 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753155AbYB2B2j (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Feb 2008 20:28:39 -0500
In-Reply-To: <200802282114.28680.arvidjaar@mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 28 Feb 2008 21:14:26 +0300 Andrey Borzenkov <arvidjaar@mail.ru> wrote:

> From: Andrey Borzenkov <arvidjaar@mail.ru>
> 
> Make sure input device for  ACPI button gets proper place
> in device tree.
> 
> Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>
> 
> ---
> 
>  drivers/acpi/button.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 24a7865..6c5da83 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -449,6 +449,7 @@ static int acpi_button_add(struct acpi_device *device)
>  	input->phys = button->phys;
>  	input->id.bustype = BUS_HOST;
>  	input->id.product = button->type;
> +	input->dev.parent = &device->dev;
>  
>  	switch (button->type) {
>  	case ACPI_BUTTON_TYPE_POWER:
> 

What are the consequences of the bug which you've fixed?

It helps very much if the changelog explains things like this so we can
decide whether the patch is needed in 2.6.25 or even 2.6.24.x.

Thanks.
