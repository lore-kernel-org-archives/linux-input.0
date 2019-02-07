From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH] Input: ps2-gpio - flush TX work when closing port
Date: Thu, 7 Feb 2019 18:03:03 -0500
Message-ID: <CAGngYiWzC92Lw+Z-BAtPfEHgys0vcQOxdxo7g_JHKHF36-Hm7Q@mail.gmail.com>
References: <20190207222740.GA38612@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190207222740.GA38612@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Danilo Krummrich <danilokrummrich@dk-develop.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Feb 7, 2019 at 5:27 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> +       flush_work(&drvdata->tx_work.work);

Would cancel_work_sync() be better than flush_work() ?
