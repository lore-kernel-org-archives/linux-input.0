From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: Increase maximum report size allowed by hid_field_extract()
Date: Thu, 25 Apr 2019 11:42:50 +0200
Message-ID: <CAO-hwJLDuMZuqKiawnkq3YxL6T9SqNGqQ1Q_Vs=kMKmsx6SD0w@mail.gmail.com>
References: <20190308051117.21899-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190308051117.21899-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Ronald_Tschal=C3=A4r?= <ronald@innovation.ch>
List-Id: linux-input@vger.kernel.org

Hi,


On Fri, Mar 8, 2019 at 6:11 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Commit 71f6fa90a353 ("HID: increase maximum global item tag report size
> to 256") increases the max report size from 128 to 256.
>
> We also need to update the report size in hid_field_extract() otherwise
> it complains and truncates now valid report size:
> [ 406.165461] hid-sensor-hub 001F:8086:22D8.0002: hid_field_extract() called with n (192) > 32! (kworker/5:1)
>
> BugLink: https://bugs.launchpad.net/bugs/1818547
> Fixes: 71f6fa90a353 ("HID: increase maximum global item tag report size to 256")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/hid/hid-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 9993b692598f..860e21ec6a49 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1301,10 +1301,10 @@ static u32 __extract(u8 *report, unsigned offset, int n)
>  u32 hid_field_extract(const struct hid_device *hid, u8 *report,
>                         unsigned offset, unsigned n)

Ronald (Cc-ed) raised quite a good point:
what's the benefit of removing the error message if this function (and
__extract) can only report an unsigned 32 bits value?

My take is we should revert 94a9992f7dbdfb28976b upstream and think at
a better solution.

Cheers,
Benjamin

>  {
> -       if (n > 32) {
> -               hid_warn(hid, "hid_field_extract() called with n (%d) > 32! (%s)\n",
> +       if (n > 256) {
> +               hid_warn(hid, "hid_field_extract() called with n (%d) > 256! (%s)\n",
>                          n, current->comm);
> -               n = 32;
> +               n = 256;
>         }
>
>         return __extract(report, offset, n);
> --
> 2.17.1
>
