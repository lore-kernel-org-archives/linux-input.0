From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 4/5] HID: intel_ish-hid: fix format string for size_t
Date: Mon, 22 May 2017 16:46:44 -0700
Message-ID: <1495496804.109485.75.camel@linux.intel.com>
References: <20170518202144.3482304-1-arnd@arndb.de>
         <20170518202144.3482304-5-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:61516 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758725AbdEVXqp (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 22 May 2017 19:46:45 -0400
In-Reply-To: <20170518202144.3482304-5-arnd@arndb.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2017-05-18 at 22:21 +0200, Arnd Bergmann wrote:
> When building for 32-bit architectures, we get a harmless warning:
> 
> intel-ish-hid/ishtp-hid-client.c: In function 'process_recv':
> intel-ish-hid/ishtp-hid-client.c:139:7: error: format '%lu' expects
> argument of type 'long unsigned int', but argument 3 has type
> 'unsigned int' [-Werror=format=]
> 
> This changes the format string to print size_t variables using %zu
> instead.
Is the ordering of patch correct?
ISH config depends on X86_64, so it would not be enabled for 32 bit
build.
So your patch 5/5 will adding "|| COMPILE_TEST", hence it is building.

Thanks,
Srinivas

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/hid/intel-ish-hid/ishtp-hid-client.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> index 5c643d7a07b2..157b44aacdff 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> @@ -136,10 +136,9 @@ static void process_recv(struct ishtp_cl
> *hid_ishtp_cl, void *recv_buf,
>  				if (1 + sizeof(struct device_info) *
> i >=
>  						payload_len) {
>  					dev_err(&client_data-
> >cl_device->dev,
> -						"[hid-ish]:
> [ENUM_DEVICES]: content size %lu is bigger than payload_len %u\n",
> +						"[hid-ish]:
> [ENUM_DEVICES]: content size %zu is bigger than payload_len %zu\n",
>  						1 + sizeof(struct
> device_info)
> -						* i,
> -						(unsigned
> int)payload_len);
> +						* i, payload_len);
>  				}
>  
>  				if (1 + sizeof(struct device_info) *
> i >=
