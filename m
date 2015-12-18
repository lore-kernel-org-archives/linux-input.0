From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 1/2] HID: Use multitouch driver for Type Covers
Date: Fri, 18 Dec 2015 16:06:42 +0100
Message-ID: <1450451202.24419.13.camel@hadess.net>
References: <1450097429-4959-1-git-send-email-akihiko.odaki.4i@stu.hosei.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450097429-4959-1-git-send-email-akihiko.odaki.4i@stu.hosei.ac.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Akihiko Odaki <akihiko.odaki.4i@stu.hosei.ac.jp>, jikos@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 2015-12-14 at 21:50 +0900, Akihiko Odaki wrote:
> Use multitouch driver instead of microsoft one for Microsoft Surface
> Type Covers.
> 
> By using MT_CLS_EXPORT_ALL_INPUTS, the keyboards function as well as
> the multitouch pads do.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki.4i@stu.hosei.ac.jp>

All the multimedia keys work, and MT support also works, on my Surface
3 cover (045e:07de).

*But* the Caps-Lock key's LED doesn't light up anymore. Can you verify
it does on yours as well?

Cheers
