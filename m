From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] Input: ipaq-micro-ts - introduce open/close
Date: Thu, 24 Jul 2014 15:30:29 +0200
Message-ID: <CACRpkdZUqRPzZGWmU0=XpR9pnFUPYZiCewuEqnpfH1jOpXAOZw@mail.gmail.com>
References: <20140723173625.GA38489@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140723173625.GA38489@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Alessandro GARDICH <gremlin@gremlin.it>, Dmitry Artamonow <mad_soft@inbox.ru>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Jul 23, 2014 at 7:36 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Wire up open/close so we do not try to send events until someone uses them;
> this also allows us to remove micro_ts_remove() and rely fully on managed
> resources.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Looks good.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
