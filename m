From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 4/4] HID: uclogic: name the input nodes based on their
 tool
Date: Wed, 25 Feb 2015 23:04:58 +0200
Message-ID: <54EE38FA.8070702@gmail.com>
References: <1424822730-14938-1-git-send-email-benjamin.tissoires@redhat.com> <1424822730-14938-5-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424822730-14938-5-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>
List-Id: linux-input@vger.kernel.org

On 02/25/2015 02:05 AM, Benjamin Tissoires wrote:
> We append "Pen", "Pad", "Mouse" or "Keyboard" suffix to the appropriate
> input node to match what the Wacom driver does and be more convenient for
> the user to know which one is which.

As I said before, this is a very welcome change. Thanks, Benjamin!
However, I'm not familiar with input_configured hook yet, so cannot give my
Reviewed-by.

> +	if (suffix) {
> +		len = strlen(hdev->name) + 2 + strlen(suffix);
> +		name = devm_kzalloc(&hi->input->dev, len, GFP_KERNEL);
> +		if (name) {
> +			snprintf(name, len, "%s %s", hdev->name, suffix);
> +			hi->input->name = name;
> +		}

I only feel a bit uneasy about duplicating buffer size knowledge here, as I
said before, but the code is short, so it'll probably be OK.

Nick
