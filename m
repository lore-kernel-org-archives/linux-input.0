From: Bjorn Andersson <bjorn@kryo.se>
Subject: Re: Qualcomm PMIC8XXX keypad never worked?
Date: Tue, 11 Mar 2014 22:18:29 -0700
Message-ID: <CAJAp7OgF235DNLC9aaxh15SPwVir9QBjgfi_C1gvmX-o3bHZ9g@mail.gmail.com>
References: <5887114.1jrNo21sGX@wuerfel> <20140311120056.GH21216@lee--X1>
 <8206209.oc1V5pPVYT@wuerfel> <20140311130609.GL21216@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140311130609.GL21216@lee--X1>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Trilok Soni <tsoni@codeaurora.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org, Anirudh Ghayal <aghayal@codeaurora.org>
List-Id: linux-input@vger.kernel.org

On Tue, Mar 11, 2014 at 6:06 AM, Lee Jones <lee.jones@linaro.org> wrote:
[snip]
>
> ... but the MFD isn't broken, so I guess your solution is the most
> elegant. If it's not fixed soon, I guess we should think about ripping
> it out. It's obvoious that no-one cares, as it's been broken for
> nearly 3 years.

Stephen Boyd have a series out on these drivers; fixing this, turning
them DT and some other goodies.

The related part for this would be:
https://patchwork.kernel.org/patch/3765191/

Unfortunately lkml.org seems down, so I can't link to the series.

Regards,
Bjorn
