From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 3/4] HID: uclogic: present only the working interfaces
 on the Huion tablets
Date: Wed, 25 Feb 2015 23:04:49 +0200
Message-ID: <54EE38F1.10202@gmail.com>
References: <1424822730-14938-1-git-send-email-benjamin.tissoires@redhat.com> <1424822730-14938-4-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424822730-14938-4-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>
List-Id: linux-input@vger.kernel.org

On 02/25/2015 02:05 AM, Benjamin Tissoires wrote:
> The Huion tablets show 3 interfaces. Only the first and the third
> are currently used.
> Also remove HID_QUIRK_MULTI_INPUT for the third interface to not
> create more than needed input nodes.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>   drivers/hid/hid-uclogic.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
> index 397f1df..c03e076 100644
> --- a/drivers/hid/hid-uclogic.c
> +++ b/drivers/hid/hid-uclogic.c
> @@ -840,6 +840,11 @@ static int uclogic_probe(struct hid_device *hdev,
>   				hid_err(hdev, "tablet enabling failed\n");
>   				return rc;
>   			}
> +		} else if (intf->cur_altsetting->desc.bInterfaceNumber == 2) {
> +			hdev->quirks &= ~HID_QUIRK_MULTI_INPUT;
> +		} else {
> +			/* Ignore all unused interfaces */
> +			return -ENODEV;
>   		}
>   		break;
>   	}
>

I would hesitate to remove the mouse interface as there are relatively fresh
UC-Logic tablets [1] out there which have a mouse, and which could respond to
the initialization. These mice are of questionable usefulness, true, but
leaving the interface enabled could make it easier for other people to
experiment with using this driver with their tablets.

What do you think, Benjamin?

Nick

[1] http://digimend.github.io/tablets/UC-Logic_TWHL850/
