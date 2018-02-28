From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 2/4] HID: steam: add serial number information.
Date: Wed, 28 Feb 2018 22:17:50 +0200
Message-ID: <CAHp75VfxaxLJWK1Hk9PRiU0L2MuLPX5VoPsn6RRmmXg-apXo6Q@mail.gmail.com>
References: <20180228184322.29636-1-rodrigorivascosta@gmail.com> <20180228184322.29636-3-rodrigorivascosta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180228184322.29636-3-rodrigorivascosta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, Cameron Gutman <aicommander@gmail.com>, =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Feb 28, 2018 at 8:43 PM, Rodrigo Rivas Costa
<rodrigorivascosta@gmail.com> wrote:
> This device has a feature report to send and receive commands.
> Use it to get the serial number and set the device's uniq value.

>  #include <linux/module.h>
>  #include <linux/workqueue.h>
>  #include <linux/rcupdate.h>

> +#include <linux/delay.h>

Better to keep it somehow sorted (yes, I see it's not originally, but
better to squeeze new header to the most ordered part).


> @@ -41,8 +42,99 @@ struct steam_device {
>         unsigned long quirks;
>         struct work_struct work_connect;
>         bool connected;

> +       char serial_no[11];

11 is a magic.

>  };
>
> +static int steam_recv_report(struct steam_device *steam,
> +               u8 *data, int size)
> +{
> +       struct hid_report *r;
> +       u8 *buf;
> +       int ret;
> +
> +       r = steam->hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[0];
> +       if (hid_report_len(r) < 64)
> +               return -EINVAL;

+ empty line.

> +       buf = hid_alloc_report_buf(r, GFP_KERNEL);
> +       if (!buf)
> +               return -ENOMEM;
> +
> +       /*
> +        * The report ID is always 0, so strip the first byte from the output.
> +        * hid_report_len() is not counting the report ID, so +1 to the length
> +        * or else we get a EOVERFLOW. We are safe from a buffer overflow
> +        * because hid_alloc_report_buf() allocates +7 bytes.
> +        */
> +       ret = hid_hw_raw_request(steam->hdev, 0x00,
> +                       buf, hid_report_len(r) + 1,
> +                       HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
> +       if (ret > 0)
> +               memcpy(data, buf + 1, min(size, ret - 1));
> +       kfree(buf);
> +       return ret;
> +}
> +
> +static int steam_send_report(struct steam_device *steam,
> +               u8 *cmd, int size)
> +{
> +       struct hid_report *r;
> +       u8 *buf;
> +       int retry;
> +       int ret;
> +
> +       r = steam->hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[0];
> +       if (hid_report_len(r) < 64)
> +               return -EINVAL;

+empty line.

> +       buf = hid_alloc_report_buf(r, GFP_KERNEL);
> +       if (!buf)
> +               return -ENOMEM;
> +
> +       /* The report ID is always 0 */
> +       memcpy(buf + 1, cmd, size);
> +
> +       /*
> +        * Sometimes the wireless controller fails with EPIPE
> +        * when sending a feature report.
> +        * Doing a HID_REQ_GET_REPORT and waiting for a while
> +        * seems to fix that.
> +        */

> +       for (retry = 0; retry < 10; ++retry) {
> +               ret = hid_hw_raw_request(steam->hdev, 0,
> +                               buf, size + 1,
> +                               HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
> +               if (ret != -EPIPE)
> +                       break;
> +               steam_recv_report(steam, NULL, 0);
> +               msleep(50);
> +       }

Personally I consider do{}while in case of "timeout loops" much easier to parse.

unsigned int retry = 10;
...

do {
...
} while (--retry);

> +       kfree(buf);
> +       if (ret < 0)
> +               hid_err(steam->hdev, "%s: error %d (%*ph)\n", __func__,
> +                               ret, size, cmd);
> +       return ret;
> +}
> +
> +static int steam_get_serial(struct steam_device *steam)
> +{
> +       /*
> +        * Send: 0xae 0x15 0x01
> +        * Recv: 0xae 0x15 0x01 serialnumber (10 chars)
> +        */
> +       int ret;
> +       u8 cmd[] = {0xae, 0x15, 0x01};

> +       u8 reply[14];
> +
> +       ret = steam_send_report(steam, cmd, sizeof(cmd));
> +       if (ret < 0)
> +               return ret;
> +       ret = steam_recv_report(steam, reply, sizeof(reply));
> +       if (ret < 0)
> +               return ret;


> +       reply[13] = 0;
> +       strcpy(steam->serial_no, reply + 3);

strlcpy()

> +       return 0;
> +}


-- 
With Best Regards,
Andy Shevchenko
