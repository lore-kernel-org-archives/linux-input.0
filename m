From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 3/3] HID: Device attributes for hid-penmount
Date: Wed, 19 Aug 2015 09:48:41 -0400
Message-ID: <CAN+gG=GTjRiM-yNfdngeUQd3maxPv0o7miHMFHc1j0gy7982Zw@mail.gmail.com>
References: <1439969399-11469-1-git-send-email-penmount.touch@gmail.com>
	<1439969399-11469-3-git-send-email-penmount.touch@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439969399-11469-3-git-send-email-penmount.touch@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Sung <penmount.touch@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Aug 19, 2015 at 3:29 AM, John Sung <penmount.touch@gmail.com> wrote:
> Add two attributes, ver and cmd, to provide more convenient way to
> integrate with shell scripts.

Please don't.
If the user space wants to talk to the device, use the plain hidraw
interface. Adding such a new API would mean that you need to add
documentation for it, maintain it undefinitely (even if your new user
space don't use it anymore, some people might still rely on it), and
if you have a slightly different chip on your panel, you will have to
patch the kernel, and backport it to stable, and ask your customer to
use either a patched kernel or wait for this to hit them (which takes
several months).

While if you use hidraw, as soon as you have a different chip, you fix
the userspace, ship this to your customer and you are done.

Cheers,
Benjamin

>
> Signed-off-by: John Sung <penmount.touch@gmail.com>
> ---
>  drivers/hid/hid-penmount.c |   87 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
>
> diff --git a/drivers/hid/hid-penmount.c b/drivers/hid/hid-penmount.c
> index 4fd14c8..a59c0e0 100644
> --- a/drivers/hid/hid-penmount.c
> +++ b/drivers/hid/hid-penmount.c
> @@ -79,6 +79,88 @@ static int penmount_hid_getreport(struct penmount *pm, unsigned char *ack)
>         return ret;
>  }
>
> +static ssize_t penmount_cmd_store(struct device *dev,
> +               struct device_attribute *attr, const char *buffer, size_t count)
> +{
> +       struct penmount *pm = NULL;
> +       struct hid_device *hdev = NULL;
> +       unsigned char cmd[PM_HID_REPORT_SIZE] = { 0, 0, 0, 0, 0 };
> +
> +       hdev = dev_get_drvdata(dev);
> +       if (hdev == NULL)
> +               return -EINVAL;
> +
> +       pm = hid_get_drvdata(hdev);
> +       if ((pm == NULL) || (buffer == NULL))
> +               return -EINVAL;
> +
> +       count = sscanf(buffer, "%hhX %hhX %hhX %hhX %hhX", &cmd[0], &cmd[1],
> +               &cmd[2], &cmd[3], &cmd[4]);
> +
> +       if (penmount_hid_setreport(pm, cmd) < 0)
> +               return 0;
> +
> +       return count;
> +}
> +
> +static ssize_t penmount_cmd_show(struct device *dev,
> +               struct device_attribute *attr, char *buffer)
> +{
> +       struct penmount *pm = NULL;
> +       struct hid_device *hdev = NULL;
> +       size_t count = 0;
> +       unsigned char ack[PM_HID_REPORT_SIZE] = { 0, 0, 0, 0, 0 };
> +
> +       hdev = dev_get_drvdata(dev);
> +       if (hdev == NULL)
> +               return -EINVAL;
> +
> +       pm = hid_get_drvdata(hdev);
> +       if ((pm == NULL) || (buffer == NULL))
> +               return -EINVAL;
> +
> +       if (penmount_hid_getreport(pm, ack) < 0)
> +               return 0;
> +
> +       count = sprintf(buffer, "0x%02X 0x%02X 0x%02X 0x%02X 0x%02X\n", ack[0],
> +                       ack[1], ack[2], ack[3], ack[4]);
> +
> +       return count;
> +}
> +
> +static ssize_t penmount_ver_show(struct device *dev,
> +               struct device_attribute *attr, char *buffer)
> +{
> +       struct penmount *pm = NULL;
> +       struct hid_device *hdev = NULL;
> +       size_t count = 0;
> +
> +       hdev = dev_get_drvdata(dev);
> +       if (hdev == NULL)
> +               return -EINVAL;
> +
> +       pm = hid_get_drvdata(hdev);
> +       if ((pm == NULL) || (buffer == NULL))
> +               return -EINVAL;
> +
> +       count = sprintf(buffer, "%s\n", pm->version);
> +
> +       return count;
> +}
> +
> +static DEVICE_ATTR(ver, 0444, penmount_ver_show, NULL);
> +static DEVICE_ATTR(cmd, 0644, penmount_cmd_show, penmount_cmd_store);
> +
> +static struct attribute *penmount_attrs[] = {
> +       &dev_attr_cmd.attr,
> +       &dev_attr_ver.attr,
> +       NULL
> +};
> +
> +static const struct attribute_group penmount_attr_group = {
> +       .attrs = penmount_attrs,
> +};
> +
>  static int penmount_get_version(struct penmount *pm)
>  {
>         int ret = 0;
> @@ -354,6 +436,10 @@ static int penmount_probe(struct hid_device *hdev,
>         if (hidinput != NULL) {
>                 pm->input = hidinput->input;
>                 set_bit(INPUT_PROP_DIRECT, hidinput->input->propbit);
> +               if (sysfs_create_group(&hidinput->input->dev.kobj,
> +                               &penmount_attr_group)) {
> +                       hid_warn(hdev, "Failed to create attr group !\n");
> +               }
>         }
>
>         penmount_get_version(pm);
> @@ -368,6 +454,7 @@ static void penmount_remove(struct hid_device *hdev)
>
>         pm = hid_get_drvdata(hdev);
>         if (pm != NULL) {
> +               sysfs_remove_group(&pm->input->dev.kobj, &penmount_attr_group);
>                 kfree(pm);
>                 hid_set_drvdata(hdev, NULL);
>         }
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
