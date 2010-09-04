From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH v2 4/6 RESEND] ARM: pxa27x_keypad: added wakeup event
	handler for keypad interrupts
Date: Sat, 4 Sep 2010 15:41:36 +0800
Message-ID: <AANLkTi=oQQQdmgi5g_LL++y3dminGxXuQEQpzSKvTyRT@mail.gmail.com>
References: <1283552891-13966-1-git-send-email-mark.brown314@gmail.com>
	<1283552891-13966-5-git-send-email-mark.brown314@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1283552891-13966-5-git-send-email-mark.brown314@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Mark F. Brown" <mark.brown314@gmail.com>
Cc: linux-input@vger.kernel.org, Haojian Zhuang <haojian.zhuang@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Sep 4, 2010 at 6:28 AM, Mark F. Brown <mark.brown314@gmail.com> wrote:
> mach-mmp needs to clear wake event in order to clear the keypad interrupt
>
> Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>

Applied.
