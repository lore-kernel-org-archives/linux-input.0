From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 19/26] Input: synaptics-rmi4: Add support for packet
 register descriptors
Date: Mon, 9 Nov 2015 14:18:54 +0100
Message-ID: <CACRpkdZhOjidf2MH604E6kHmboMSESDLgvrtMqRV6EuZ71iq8g@mail.gmail.com>
References: <1446766912-31077-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446766912-31077-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>
List-Id: linux-input@vger.kernel.org

On Fri, Nov 6, 2015 at 12:41 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> Newer RMI functions make use of packet registers. Packet registers contain
> several bytes of data at a RMI address instead of just a single byte.
> Packet registers may also contain subpackets which may or may not be
> present for a given firmware configuration. Functions which use packet
> registers contain Packet Register Descriptors in their query registers.
> This patch implements the reading and processing of packet register
> descriptors.
>
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

Looks like it should be squashed into the core patch.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
