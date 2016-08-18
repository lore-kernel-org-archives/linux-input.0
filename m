From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] input: touchscreen: silead: Add regulator support
Date: Thu, 18 Aug 2016 14:22:19 -0500
Message-ID: <20160818192219.GA28941@rob-hp-laptop>
References: <1471376124-31169-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1471376124-31169-1-git-send-email-hdegoede@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: devicetree <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Tue, Aug 16, 2016 at 09:35:24PM +0200, Hans de Goede wrote:
> On some tablets the touchscreen controller is powered by seperate
> regulators, add support for this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../bindings/input/touchscreen/silead_gsl1680.txt  |  2 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/input/touchscreen/silead.c                 | 51 ++++++++++++++++++++--
>  2 files changed, 49 insertions(+), 4 deletions(-)
