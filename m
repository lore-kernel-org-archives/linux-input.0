From: Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v3 1/2] Input: atmel_mxt_ts - Support for touchpad variant
Date: Thu, 7 Mar 2013 22:57:19 -0800
Message-ID: <CANLzEks+1DS8qUwbyVQU6WdyT2pKYKWYJGNOjyExR8dGG0AHng@mail.gmail.com>
References: <1362187254-9227-1-git-send-email-bleung@chromium.org>
	<1362714214-32405-1-git-send-email-bleung@chromium.org>
	<1362714214-32405-2-git-send-email-bleung@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1362714214-32405-2-git-send-email-bleung@chromium.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Olof Johansson <olofj@chromium.org>, Yufeng Shen <miletus@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Matthew Garrett <matthew.garrett@nebula.com>, Henrik Rydberg <rydberg@euromail.se>, Daniel Kurtz <djkurtz@chromium.org>, Joonyoung Shim <jy0922.shim@samsung.com>, wfp5p@virginia.edu, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
Cc: Benson Leung <bleung@chromium.org>, David Miller <davem@davemloft.net>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

On Thu, Mar 7, 2013 at 7:43 PM, Benson Leung <bleung@chromium.org> wrote:
> +static void mxt_input_button(struct mxt_data *data, struct mxt_message *message)
> +{
> +       struct device *dev = &data->client->dev;
Oops. I missed a warning: unused variable 'dev' here.

> +       struct input_dev *input = data->input_dev;
> +       bool button;
> +       int i;
> +
> +       /* Active-low switch */
> +       for (i = 0; i < MXT_NUM_GPIO; i++) {
> +               if (data->pdata->key_map[i] == KEY_RESERVED)
> +                       continue;
> +               button = !(message->message[0] & MXT_GPIO0_MASK << i);
> +               input_report_key(input, data->pdata->key_map[i], button);
> +       }
> +}
> +




--
Benson Leung
Software Engineer, Chrom* OS
bleung@chromium.org
