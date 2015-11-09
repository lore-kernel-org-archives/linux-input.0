From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 15/26] Input: synaptics-rmi4: Remove unused debugfs code
Date: Mon, 9 Nov 2015 14:13:30 +0100
Message-ID: <CACRpkdaW5-0dx8=e_u87G6fb3WG-NHVtvXVc-oSZSmun4oJWSA@mail.gmail.com>
References: <1446766856-30897-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446766856-30897-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>
List-Id: linux-input@vger.kernel.org

On Fri, Nov 6, 2015 at 12:40 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> Previous versions of the driver reported statistics in debugfs.
> But that code has been removed and debugfs is no longer used. This
> patch removes all remaining debugfs code.
>
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Squash into the core bus part to make it lean, mean and clean.

Yours,
Linus Walleij
