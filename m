From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 1/5] HID: intel_ish-hid: fix potential uninitialized
 data usage
Date: Mon, 22 May 2017 12:17:01 -0700
Message-ID: <1495480621.109485.60.camel@linux.intel.com>
References: <20170518202144.3482304-1-arnd@arndb.de>
         <20170518202144.3482304-2-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41407 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753021AbdEVTRC (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 22 May 2017 15:17:02 -0400
In-Reply-To: <20170518202144.3482304-2-arnd@arndb.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Arnd,
On Thu, 2017-05-18 at 22:21 +0200, Arnd Bergmann wrote:
> gcc points out an uninialized pointer dereference that could happen
> if we ever get to recv_ishtp_cl_msg_dma() or recv_ishtp_cl_msg()
> with an empty &dev->read_list:
> 
> drivers/hid/intel-ish-hid/ishtp/client.c: In function
> 'recv_ishtp_cl_msg_dma':
> drivers/hid/intel-ish-hid/ishtp/client.c:1049:3: error: 'cl' may be
> used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> The warning only appeared in very few randconfig builds, as the
> spinlocks tend to prevent gcc from tracing the variables. I only
> saw it in configurations that had neither SMP nor LOCKDEP enabled.
> 
> As we can see, we only enter the case if 'complete_rb' is non-NULL,
> and then 'cl' is known to point to complete_rb->cl. Adding another
> initialization to the same pointer is harmless here and makes it
> clear to the compiler that the behavior is well-defined.
> 
Did you get chance to test these changes on a platform with ISH?

Thanks,
Srinivas

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/hid/intel-ish-hid/ishtp/client.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/intel-ish-hid/ishtp/client.c
> b/drivers/hid/intel-ish-hid/ishtp/client.c
> index aad61328f282..78d393e616a4 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/client.c
> +++ b/drivers/hid/intel-ish-hid/ishtp/client.c
> @@ -925,6 +925,7 @@ void recv_ishtp_cl_msg(struct ishtp_device *dev,
>  	}
>  
>  	if (complete_rb) {
> +		cl = complete_rb->cl;
>  		getnstimeofday(&cl->ts_rx);
>  		++cl->recv_msg_cnt_ipc;
>  		ishtp_cl_read_complete(complete_rb);
> @@ -1045,6 +1046,7 @@ void recv_ishtp_cl_msg_dma(struct ishtp_device
> *dev, void *msg,
>  	}
>  
>  	if (complete_rb) {
> +		cl = complete_rb->cl;
>  		getnstimeofday(&cl->ts_rx);
>  		++cl->recv_msg_cnt_dma;
>  		ishtp_cl_read_complete(complete_rb);
