From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/4] input: evdev: Replace timeval with timespec64
Date: Tue, 13 Sep 2016 17:08:36 +0200
Message-ID: <6200207.iSccVnhq5i@wuerfel>
References: <1473775805-2242-1-git-send-email-deepa.kernel@gmail.com> <1473775805-2242-3-git-send-email-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473775805-2242-3-git-send-email-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, y2038@lists.linaro.org
List-Id: linux-input@vger.kernel.org

On Tuesday, September 13, 2016 7:10:03 AM CEST Deepa Dinamani wrote:
> struct timeval is not y2038 safe.
> 
> All references to timeval in the kernel will be replaced
> by y2038 safe structures.
> Replace all references to timeval with y2038 safe
> struct timespec64 here.
> 
> struct input_event will be changed in a different patch.
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> ---
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
