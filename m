From: Dmitry Artamonow <mad_soft@inbox.ru>
Subject: Re: [PATCH v3 1/2] pxa/hx4700: Add Synaptics NavPoint (PXA27x
 SSP/SPI) driver
Date: Wed, 23 Nov 2011 23:51:44 +0400
Message-ID: <20111123195144.GB9918@rainbow>
References: <1322066725.99549.YahooMailClassic@web29017.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1322066725.99549.YahooMailClassic@web29017.mail.ird.yahoo.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Parsons <lost.distance@yahoo.com>
Cc: eric.y.miao@gmail.com, koen@dominion.thruhere.net, dmitry.torokhov@gmail.com, philipp.zabel@gmail.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On 16:45 Wed 23 Nov     , Paul Parsons wrote:
> Add support for the Synaptics NavPoint touchpad connected to a PXA27x SSP port
> in SPI slave mode. The driver implements a simple navigation pad. The four
> raised dots are mapped to UP/DOWN/LEFT/RIGHT buttons and the centre of the
> touchpad is mapped to the ENTER button.
> 
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> ---

Both patches look good to me. Sadly, I can't test them as Navpoint on my
hx4700 is broken for a long time :(

BTW, it's funny that driver is placed in input/mouse, but actually
reports only keyboard events :)
Anyway, reporting coordinates can be added at some later point.

-- 
Best regards,
Dmitry "MAD" Artamonow
