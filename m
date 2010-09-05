From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 4/5] input: wacom: Add support for the Bamboo Touch trackpad
 (rev4)
Date: Sun, 05 Sep 2010 12:04:00 +0200
Message-ID: <4C836B10.4040407@euromail.se>
References: <1283607783-29388-1-git-send-email-rydberg@euromail.se> <1283607783-29388-5-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1283607783-29388-5-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 09/04/2010 03:43 PM, Henrik Rydberg wrote:

[...]

>@@ -955,6 +1007,12 @@ void wacom_setup_device_quirks(struct wacom
> 	if (features->type == TABLETPC || features->type == TABLETPC2FG ||
> 	    features->type == BAMBOO_PT)
> 		features->quirks |= WACOM_QUIRK_MULTI_INPUT;
>+
>+	/* quirks for bamboo touch */
>+	if (features->type == BAMBOO_PT) {

This line should have "&& features->device_type == BTN_TOOL_TRIPLETAP" appended
to it, to only target the touch device of Pen & Touch.

>+		features->pressure_max = 256;
>+		features->pressure_fuzz = 16;
>+	}
> }

Henrik
