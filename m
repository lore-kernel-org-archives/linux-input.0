From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: intel-ish-hid: fixes incorrect error handling
Date: Fri, 7 Dec 2018 15:23:29 +0100
Message-ID: <CAO-hwJJDhtNqy6gc9OJ+rHnJimrQeAoxxkay5XnfXjxMtvEufQ@mail.gmail.com>
References: <1542847953-127599-1-git-send-email-bianpan2016@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542847953-127599-1-git-send-email-bianpan2016@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bianpan2016@163.com
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Nov 22, 2018 at 1:52 AM Pan Bian <bianpan2016@163.com> wrote:
>
> The memory chunk allocated by hid_allocate_device() should be released
> by hid_destroy_device(), not kfree().
>
> Fixes: 0b28cb4bcb1("HID: intel-ish-hid: ISH HID client driver")
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  drivers/hid/intel-ish-hid/ishtp-hid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.c b/drivers/hid/intel-ish-hid/ishtp-hid.c
> index cd23903..e918d78 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-hid.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid.c
> @@ -222,7 +222,7 @@ int ishtp_hid_probe(unsigned int cur_hid_dev,
>  err_hid_device:
>         kfree(hid_data);
>  err_hid_data:
> -       kfree(hid);
> +       hid_destroy_device(hid);

Looks good to me. Srinivas, any comments?
FWIW:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Jiri, do you think we should send this one as 4.20/fixes material or
wait for 4.21?

Cheers,
Benjamin

>         return rv;
>  }
>
> --
> 2.7.4
>
>
