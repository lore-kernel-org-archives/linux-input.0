From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 00/11] Input: synaptics-rmi4: various fixes for the
 existing rmi4 branch
Date: Wed, 4 Nov 2015 14:55:27 +0100
Message-ID: <CACRpkdZs60LVAsHOSb9J79SeMFDj1-PmsoewL0ebWgKfrEorCA@mail.gmail.com>
References: <1435087050-11444-1-git-send-email-benjamin.tissoires@redhat.com>
	<20150723171041.GA14941@mail.corp.redhat.com>
	<CACRpkdamzJbxaBjJGGC7gq7Vqadtn30creAk-S1vtg02OoA9RQ@mail.gmail.com>
	<5637E03B.5010804@synaptics.com>
	<CACRpkdbu8b=rNggjj7uL+E4DCD0A4xDSmhCa9K-SGWJS-dhoVw@mail.gmail.com>
	<5639539F.2050406@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5639539F.2050406@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Nov 4, 2015 at 1:38 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> Great! I'll look into the issues you highlighted above and start posting
> patches soon. Thanks for reviewing!

I think you should also squash all fixes into the logical steps in the previous
patch series or just squash the entire history and send it out in totally
new, logical chunks of functionality.

The credits can be preserved by just stacking on some signed-off-by
in the end of the patch. Author: is usually set to whoever wrote the
majority of the code, but I suspect few care too much as long as
they're mentioned.

Yours,
Linus Walleij
