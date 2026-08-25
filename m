Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156193CB56A
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787688157; cv=pass; b=Wy3QwC9u/pKxdezctJh0rQSwXnjbqHo/H+yGd3WAcAeoi0Y0CSy04gw5Z0mrJFq9ZjQpWlU1LzFTLV78ttRxXVisKcDfnINzhyDB493vri+xXi1kfoyux7xUz2YOkGfhkUy5F2J2ni2D3Ix+1nRYl1PpoXbhJq8lbcBKE3QnLyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787688157; c=relaxed/simple;
	bh=yXVhVSQdylmP/Yu8+FYZlL6s0rOxGR4ZZMn7NL5EdSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ddiQFK0dOw9EdRlYZBFJ3GqLRU20gR9+jpLil9dob4ksT7EQMbCiTfGUWSRYldN9l2oNvnDDzuv8cIxdfRN1Q3F4w/H+H0Oq3xuG4WkRrIq++FHErKUHpNp/ORLCSk0r1U7u8YBLDZEEwvk1mj9PQDtDtZgwFovUYbbhdWY7HAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5zLBT30; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5zLBT30"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8f23e851626so1569006d6.3
        for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 13:02:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787688155; cv=none;
        d=google.com; s=arc-20260327;
        b=XezuIMRc3X5vCo7swNXXUUVP9NAZ5vCwEHdhw9f0Hmf1vm8Mb7A7MeX1YMD073t2/1
         ca+Q7MRu97fJPa5SyDt4d847s8+dKGCrbqZ9p+xzsjEk8nW6Tm/fTXXaqHCpMBp0LAen
         FZiMEYo72HIWBgvKRtYPpZ0WQn2ckPlxQHLznKwU9KMImmSrAvdMxJfb2FuNkQbLxSpO
         A1Xbad0/nYgYfSuYxJHio9n5dM8/CouD0rEZu0cDPkOd3JhbdPxGAp64dOmzuVtE+LMc
         mVn4XQu2ZQ7xEVvjqGSYaC++93omxuRLfTsucSkOGOOE14n1UZvIzi25Vg2UwJ/TzUFm
         gKKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=APRLRpaHE/HM/ic1QJIEWdGdKrIakyQ9TM8vghWdQaU=;
        fh=BuKczTSWQiM8+O4cZ8av451ppZf/yT244zI7mBtdNnM=;
        b=GuU6kpO/z3jHFq0qYFbL5FU309wGkHDp5qqQAeLqpK03LXYH4ORqgzvwtuHb4x6OWl
         0usbxU6+ZnuQKXlZ8e4NqtlnW5XHG2GPV7MHiHFk/gfdpHIXMi0Dcpm/3CRqt7w8CVLm
         qiFcBNmrLcDNtSSHofLTWRDA/rp7cRFAPGpcWLcW1hdzrJICIpsR6EFv8+32y7HeG1TE
         YRqUG/iumBNaZyvHu5Xcq/qIk8KVA6oyIK6VA8tTYuzeYQheN0dE2Xs0QWi1nUYPBRsd
         PyzW+jj8poyuaAGhajj9n/ISZ2TTC4Z/6uKauAKysOxisMD9eTK2Ap71hEoGFwtOkDV0
         Yaxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787688155; x=1788292955; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=APRLRpaHE/HM/ic1QJIEWdGdKrIakyQ9TM8vghWdQaU=;
        b=P5zLBT30xPuxcvT2CGLQGtKvL8aTFtaBBr3MrjVSAFgI2QhIy8lUFsUSnMHInKXyIc
         ypCBshX9w1k89yVRSxMYmqJy8O7lKFdRsmwL4RCSl2G/M4QWaxvq7rSedaaeDgvrfLVb
         RO8Gk3y1AsrsAmJjW38FCUZ2tgqWzo2YfsMssqIEawG3KtRT6ffx+j3NQndbQGFhAOTD
         BuxTmoa46uF/ffJeRLfgFensXy1Kk0rsO2kN3jbWfS73WonBgZIKt+5KPxY6xreAi7yT
         lv10Vhy15seqZvPw4cS1VClrVxMLirvVUhqVulZawyo12mUQ0XCI/NNqYtAUxIH93fs8
         XnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787688155; x=1788292955;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=APRLRpaHE/HM/ic1QJIEWdGdKrIakyQ9TM8vghWdQaU=;
        b=KpjxV1zUEa5maxGnJHEVqyYgjU60WYHpD4dMsVadZ5gQYN3iJlEMb+JuVmR5WSP3HQ
         H2Il0lVnbO4BtGdisbR/RUbpQfsxwGpVPwoxFKadthLHV1hqLRsP/WObttkVpGyFynrh
         i+IpWZHoRjjjV7QqUVGEUbQt1xfyFaZmKWoAlkkWfFYn/g5PAk4X90a+pkD0IuhpfAGB
         Myypm3FNefHjD6T8tnaDKKamUGVnGSpmCMV9ZoMWVap+kBP/duW9lSRLBpDD0GpFz9Il
         Ip+Oasas3xURropl7HEF+CkBWN9HzooAESXB8KIxqDoavBiSH+F2wK7SOo/JRcU4s4Js
         TsCw==
X-Forwarded-Encrypted: i=1; AHgh+RpMj9TenhiTdJo3BHjbgjou7bnpFludFwvbZRJZyCkm7A1m16l8RQNEEt4iBIEBMnpYaRX+t7QM8+zhnA==@vger.kernel.org
X-Gm-Message-State: AFuF++nYUEKet2LsypAM+YubzQZhu6CXDgUDO1kHXIp8ge059YepEksl
	YRLue4BSO6mDloPeMF7bXOfa2GF3xTyO5y6ue8DS75s74YHsPee4sptiU2x5+b+yd6Fd6HD5JFN
	d1ZXN3r3aJY+6m8dQXUdimJXQgJqAQOc=
X-Gm-Gg: AR+sD11tYOdn0kVT59xLUIyVWXTJRIyc0C3wdktXv9poZ/prmnrt8rnlMZ7Xnc5oI4e
	89QXSLvm1nwvncmJowU5u6L4+WRHHSYBW/l863c7aBFZrT7PdaVy8P2RHU1KY+D39u9NN52nUqx
	773CbxAT+jzM7kN7ZRqOwPOPEmzZ6f//cFImCiDDSCQPTnuFJrZpRtsub5bbJVSTTtdaXjBtPk5
	004KbX3V+EhKvWSs5uHIJrNBGP7RCjpecQ0Ok3M+IJ1WlW88C5RmF2q+bsM/zWiGueUejrpNsBc
	3VCi0AefXiLCLEb2f5KaA2+DeZlj91CA8HQ4Roub3aw25eo8n7oQiDx1
X-Received: by 2002:a05:6214:5b03:b0:90c:c53c:a032 with SMTP id
 6a1803df08f44-90cc7970a96mr14419096d6.25.1787688154856; Tue, 25 Aug 2026
 13:02:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821214810.87826-1-mradityadash@gmail.com> <20260821214810.87826-6-mradityadash@gmail.com>
In-Reply-To: <20260821214810.87826-6-mradityadash@gmail.com>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Tue, 25 Aug 2026 13:02:23 -0700
X-Gm-Features: AcwNN1XmuITWo7Xo7QnxkMc3v6hbIsATce41CJGIZvqueYMCSpB7uPw-IBw3ZXM
Message-ID: <CAFqHKTk5ratSc-SveBmmd1vHy5XnLnZA6ZeF7GokwdZT-95eGQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] HID: hid-lenovo-go: return configuration request errors
To: Aditya Dash <mradityadash@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 2:48=E2=80=AFPM Aditya Dash <mradityadash@gmail.com=
> wrote:
>
> The driver completes a pending request when it receives any decoded
> configuration reply. It also discards the result of its interruptible wai=
t.
> A configuration operation can therefore report success after an unrelated
> reply, firmware error, interrupted wait, or timeout.
>
> Track one pending request and match replies by command ID, command,
> sub-command, and device. Return output errors, firmware errors, interrupt=
ed
> waits, and timeouts to the caller. Treat a timeout or interruption as fin=
al
> if a matching reply arrives after the wait finishes.
>
> Calibration completion is asynchronous, and some Start commands do not se=
nd
> an immediate reply. Submit each exact calibration command and sub-command
> pair once and return its HID output status without a synchronous wait.
>
> The firmware does not include a sequence number. A late reply with the sa=
me
> complete tuple can still match a newer request.
>
> Fixes: d69ccfcbc955 ("HID: hid-lenovo-go: Add Lenovo Legion Go Series HID=
 Driver")
> Assisted-by: Pi:gpt-5.6-sol
> Signed-off-by: Aditya Dash <mradityadash@gmail.com>
> ---
> On an Original Legion Go, left-joystick Start did not return an
> immediate reply in two controller sessions although firmware began
> calibration. A focused target-kernel KUnit test covered timeout,
> interruption, firmware error, and reply ownership. No natural firmware
> rejection was reproduced.
>
>  drivers/hid/hid-lenovo-go.c | 118 ++++++++++++++++++++++++++++++------
>  1 file changed, 100 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index 1e6915c969d8..a1a255c28e2d 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c
> @@ -21,6 +21,7 @@
>  #include <linux/led-class-multicolor.h>
>  #include <linux/mutex.h>
>  #include <linux/printk.h>
> +#include <linux/spinlock.h>
>  #include <linux/sysfs.h>
>  #include <linux/types.h>
>  #include <linux/unaligned.h>
> @@ -31,13 +32,30 @@
>  #include "hid-ids.h"
>
>  #define GO_GP_INTF_IN          0x83
> +#define GO_INPUT_REPORT_ID     0x04
>  #define GO_OUTPUT_REPORT_ID    0x05
>  #define GO_GP_RESET_SUCCESS    0x01
>  #define GO_PACKET_SIZE         64
>
> +/* Lenovo replies identify a command and a sub-command, but have no sequ=
ence. */
> +struct hid_go_cmd {
> +       struct completion done;
> +       spinlock_t lock; /* protects fields below */
> +       bool pending;
> +       u8 id;
> +       u8 command;
> +       u8 sub_command;
> +       u8 device;
> +       int result;
> +};
> +
> +static struct hid_go_cmd go_cmd =3D {
> +       .done =3D COMPLETION_INITIALIZER(go_cmd.done),
> +       .lock =3D __SPIN_LOCK_UNLOCKED(go_cmd.lock),
> +};
> +
Hi Aditya,

Something that will need to happen in the future is making drvdata
instantiated with devm_alloc rather than use a global. To avoid adding
more churn to that effort, can you make this a member of the drvdata
struct and instantiate its members in cfg_probe()?

>  static struct hid_go_cfg {
>         struct delayed_work go_cfg_setup;
> -       struct completion send_cmd_complete;
>         struct led_classdev *led_cdev;
>         struct hid_device *hdev;
>         struct mutex cfg_mutex; /*ensure single synchronous output report=
*/
> @@ -331,6 +349,72 @@ static const char *const os_mode_text[] =3D {
>         [LINUX] =3D "linux",
>  };
>
> +static void hid_go_cmd_arm(u8 id, u8 command, u8 sub_command, u8 device)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&go_cmd.lock, flags);

Please use guard(spinlock_irqsave, &go_cmd.lock) and #include
<linux/cleanup.h> if it's not already in the list (applies to all
below instances)

> +       reinit_completion(&go_cmd.done);
> +       go_cmd.pending =3D true;
> +       go_cmd.id =3D id;
> +       go_cmd.command =3D command;
> +       go_cmd.sub_command =3D sub_command;
> +       go_cmd.device =3D device;
> +       spin_unlock_irqrestore(&go_cmd.lock, flags);
> +}
> +
> +static void hid_go_cmd_consume(const struct command_report *cmd_rep, int=
 result)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&go_cmd.lock, flags);
> +       if (go_cmd.pending && cmd_rep->id =3D=3D go_cmd.id &&
> +           cmd_rep->cmd =3D=3D go_cmd.command &&
> +           cmd_rep->sub_cmd =3D=3D go_cmd.sub_command &&
> +           cmd_rep->device_type =3D=3D go_cmd.device) {
> +               go_cmd.pending =3D false;
> +               go_cmd.result =3D result;
> +               complete(&go_cmd.done);
> +       }
> +       spin_unlock_irqrestore(&go_cmd.lock, flags);
> +}
> +
> +static int hid_go_cmd_finish(long wait_result)
> +{
> +       unsigned long flags;
> +       int ret;
> +
> +       spin_lock_irqsave(&go_cmd.lock, flags);
> +       if (wait_result <=3D 0) {
> +               go_cmd.pending =3D false;
> +               ret =3D wait_result < 0 ? wait_result : -ETIMEDOUT;
> +       } else {
> +               ret =3D go_cmd.result;
> +       }
> +       spin_unlock_irqrestore(&go_cmd.lock, flags);
> +       return ret;
> +}
> +
> +static int hid_go_cmd_cancel(int result)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&go_cmd.lock, flags);
> +       go_cmd.pending =3D false;
> +       spin_unlock_irqrestore(&go_cmd.lock, flags);
> +       return result;
> +}
> +
> +static int hid_go_send_output_report(struct hid_device *hdev, u8 *packet=
)
> +{
> +       int ret;
> +
> +       ret =3D hid_hw_output_report(hdev, packet, GO_PACKET_SIZE);
> +       if (ret < 0)
> +               return ret;
> +       return ret =3D=3D GO_PACKET_SIZE ? 0 : -EINVAL;
> +}
> +
>  static int hid_go_version_event(struct command_report *cmd_rep)
>  {
>         switch (cmd_rep->sub_cmd) {
> @@ -658,6 +742,8 @@ static int hid_go_raw_event(struct hid_device *hdev, =
struct hid_report *report,
>
>         if (size !=3D GO_PACKET_SIZE)
>                 goto passthrough;
> +       if (data[0] !=3D GO_INPUT_REPORT_ID)
use || instead of two ifs
> +               goto passthrough;
>
>         ep =3D get_endpoint_address(hdev);
>         if (ep !=3D GO_GP_INTF_IN)
> @@ -709,7 +795,7 @@ static int hid_go_raw_event(struct hid_device *hdev, =
struct hid_report *report,
>         dev_dbg(&hdev->dev, "Rx data as raw input report: [%*ph]\n",
>                 GO_PACKET_SIZE, data);
>
> -       complete(&drvdata.send_cmd_complete);
> +       hid_go_cmd_consume(cmd_rep, ret);
>         return ret;
>
>  passthrough:
> @@ -725,6 +811,7 @@ static int mcu_property_out(struct hid_device *hdev, =
u8 id, u8 command,
>         u8 header[] =3D { GO_OUTPUT_REPORT_ID, id, command, index, device=
 };
>         size_t header_size =3D ARRAY_SIZE(header);
>         int timeout =3D 50;
> +       long wait_result;
>         int ret;
>
>         /* The FPS mode DPI request does not contain a device byte. */
> @@ -747,22 +834,19 @@ static int mcu_property_out(struct hid_device *hdev=
, u8 id, u8 command,
>         dev_dbg(&hdev->dev, "Send data as raw output report: [%*ph]\n",
>                 GO_PACKET_SIZE, dmabuf);
>
> -       ret =3D hid_hw_output_report(hdev, dmabuf, GO_PACKET_SIZE);
> -       if (ret < 0)
> -               return ret;
> +       if (id =3D=3D MCU_CONFIG_DATA &&
> +           ((command =3D=3D SET_TRIGGER_CFG && index =3D=3D TRIGGER_CALI=
BRATE) ||
> +            (command =3D=3D SET_JOYSTICK_CFG && index =3D=3D JOYSTICK_CA=
LIBRATE) ||
> +            (command =3D=3D SET_GYRO_CFG && index =3D=3D GYRO_CALIBRATE)=
))
> +               return hid_go_send_output_report(hdev, dmabuf);

It might be simpler to add a variable that is passed to
mcu_property_out that triggers this path. That will avoid this list
expanding if additional attributes are added in the future that don't
wait on completions. In hid-msi I pass the completion timeout instead
of declaring it in the function and skip wait if it is 0. A bool would
also work.

Thanks,
Derek

> -       ret =3D ret =3D=3D GO_PACKET_SIZE ? 0 : -EINVAL;
> +       hid_go_cmd_arm(id, command, index, device);
> +       ret =3D hid_go_send_output_report(hdev, dmabuf);
>         if (ret)
> -               return ret;
> -
> -       ret =3D wait_for_completion_interruptible_timeout(&drvdata.send_c=
md_complete,
> -                                                       msecs_to_jiffies(=
timeout));
> -
> -       if (ret =3D=3D 0) /* timeout occurred */
> -               ret =3D -EBUSY;
> -
> -       reinit_completion(&drvdata.send_cmd_complete);
> -       return 0;
> +               return hid_go_cmd_cancel(ret);
> +       wait_result =3D wait_for_completion_interruptible_timeout(&go_cmd=
.done,
> +                                                               msecs_to_=
jiffies(timeout));
> +       return hid_go_cmd_finish(wait_result);
>  }
>
>  static ssize_t version_show(struct device *dev, struct device_attribute =
*attr,
> @@ -2395,8 +2479,6 @@ static int hid_go_cfg_probe(struct hid_device *hdev=
,
>
>         drvdata.led_cdev =3D &go_cdev_rgb.led_cdev;
>
> -       init_completion(&drvdata.send_cmd_complete);
> -
>         /* Executing calls prior to returning from probe will lock the MC=
U. Schedule
>          * initial data call after probe has completed and MCU can accept=
 calls.
>          */
> --
> 2.55.0
>
