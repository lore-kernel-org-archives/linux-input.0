From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/2] HID: core: i2c-hid: fix size check and type usage
Date: Thu, 4 Jan 2018 11:44:04 +0100
Message-ID: <CAO-hwJ+3Dz3g410cHwz3o_0f=2J2aa=+E5RY2sG28amjw8LcHQ@mail.gmail.com>
References: <20180102173006.506-1-aaron.ma@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34912 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752721AbeADKoF (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 4 Jan 2018 05:44:05 -0500
Received: by mail-qt0-f193.google.com with SMTP id u10so1353623qtg.2
        for <linux-input@vger.kernel.org>; Thu, 04 Jan 2018 02:44:05 -0800 (PST)
In-Reply-To: <20180102173006.506-1-aaron.ma@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Ma <aaron.ma@canonical.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>

Hi Aaron,

There are quite some changes I'd like to see in this patch. See below.

On Tue, Jan 2, 2018 at 6:30 PM, Aaron Ma <aaron.ma@canonical.com> wrote:
> When convert char array with signed int, if the inbuf[x] is negative then
> upper bits will be set to 1. Fix this by using u8 instead of char.
>
> ret_size has to be at least 3, hid_input_report use it after minus 2 bytes.
>
> size should be more than 0 to keep memset safe.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/hid/hid-core.c        |  4 ++--
>  drivers/hid/i2c-hid/i2c-hid.c | 10 +++++-----

I'd like to have this patch at least split in 2. One for hid-core, one
for i2c-hid.
Both files are not targeting the same issue, so it would make sense to
not have them in the same patch.

>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 0c3f608131cf..992547771d96 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1506,7 +1506,7 @@ int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, int size,
>         if (rsize > HID_MAX_BUFFER_SIZE)
>                 rsize = HID_MAX_BUFFER_SIZE;
>
> -       if (csize < rsize) {
> +       if ((csize < rsize) && (csize > 0)) {

I would think a call to this function with a csize <= 0 is a reason to fail.

And actually, I think an other thing we shouold do is changing the
prototype to have an unsigned int for size instead of a simple int.
Tracking the impact of such change might involve a bigger patch than a
simple check here, but we should be able to at least have the compiler
complaining if some driver starts using negative values.

>                 dbg_hid("report %d is too short, (%d < %d)\n", report->id,
>                                 csize, rsize);
>                 memset(cdata + csize, 0, rsize - csize);
> @@ -1566,7 +1566,7 @@ int hid_input_report(struct hid_device *hid, int type, u8 *data, int size, int i
>         report_enum = hid->report_enum + type;
>         hdrv = hid->driver;
>
> -       if (!size) {
> +       if (size <= 0) {

This should also be solved by changing the prototype of the function.

>                 dbg_hid("empty report\n");
>                 ret = -1;
>                 goto unlock;
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index e054ee43c1e2..09404ffdb08b 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -144,10 +144,10 @@ struct i2c_hid {
>                                                    * register of the HID
>                                                    * descriptor. */
>         unsigned int            bufsize;        /* i2c buffer size */
> -       char                    *inbuf;         /* Input buffer */
> -       char                    *rawbuf;        /* Raw Input buffer */
> -       char                    *cmdbuf;        /* Command buffer */
> -       char                    *argsbuf;       /* Command arguments buffer */
> +       u8                      *inbuf;         /* Input buffer */
> +       u8                      *rawbuf;        /* Raw Input buffer */
> +       u8                      *cmdbuf;        /* Command buffer */
> +       u8                      *argsbuf;       /* Command arguments buffer */
>
>         unsigned long           flags;          /* device flags */
>         unsigned long           quirks;         /* Various quirks */
> @@ -473,7 +473,7 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
>
>         ret_size = ihid->inbuf[0] | ihid->inbuf[1] << 8;
>
> -       if (!ret_size) {
> +       if (ret_size <= 2) {

Please do a separate case, after this one. RESET is acked by a size of
0, a size of 1 or 2 is a bug that needs to be fixed from the HW point
of view.

Cheers,
Benjamin

>                 /* host or device initiated RESET completed */
>                 if (test_and_clear_bit(I2C_HID_RESET_PENDING, &ihid->flags))
>                         wake_up(&ihid->wait);
> --
> 2.14.3
>
