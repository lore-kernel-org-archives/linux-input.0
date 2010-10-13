From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH 6/6] hid: egalax: Convert to MT slots
Date: Wed, 13 Oct 2010 13:35:08 -0400
Message-ID: <1286991308.31864.192.camel@mini>
References: <1286978302-30034-1-git-send-email-rydberg@euromail.se>
	 <1286978302-30034-7-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:44204 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab0JMRfW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 13:35:22 -0400
In-Reply-To: <1286978302-30034-7-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Philipp Merkel <mail@philmerk.de>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2010-10-13 at 15:58 +0200, Henrik Rydberg wrote:
> The joojoo reports touches sequentially, one per report, which
> confuses the current driver. Convert to the MT slots protocol and use
> the stored slot information to emulate pointer movement in a stable
> manner.
> 
> Tested-by: Philipp Merkel <mail@philmerk.de>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

[...]

> @@ -122,64 +133,61 @@ static int egalax_input_mapped(struct hid_device *hdev, struct hid_input *hi,
>  	return -1;
>  }
>  
> +static void emulate_pointer(struct egalax_data *td, struct input_dev *input)
> +{
> +	struct egalax_contact *s = &td->single;
> +	struct egalax_contact *best = 0;
> +	int dbest, i;
> +
> +	for (i = 0; i < MAX_SLOTS; i++) {
> +		struct egalax_contact *f = &td->contact[i];
> +		if (f->touch) {
> +			int d = abs(f->x - s->x) + abs(f->y - s->y);
> +			if (!best || d < dbest) {
> +				best = f;
> +				dbest = d;
> +			}

Wouldn't it be better to do a real distance comparison:

int d = (f->x - s->x) * (f->x - s->x) + (f->y - s->y) * (f->y - s->y)

That should be the square of the actual distance between two contacts.

The rest looks ok to me.

-- Chase

