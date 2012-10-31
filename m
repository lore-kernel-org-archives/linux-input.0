From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 1/2] input: qt1070: add pinctrl consumer
Date: Wed, 31 Oct 2012 14:02:07 +0100
Message-ID: <20121031130207.GE19021@game.jcrosoft.org>
References: <20121023131627.GE18964@game.jcrosoft.org>
 <1350998942-713-1-git-send-email-plagnioj@jcrosoft.com>
 <CACRpkdaTciRNsG8viz19FQajFExX+ApPNcnnVBneecSe_w-EsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdaTciRNsG8viz19FQajFExX+ApPNcnnVBneecSe_w-EsA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 22:37 Tue 30 Oct     , Linus Walleij wrote:
> 
> On Tue, Oct 23, 2012 at 3:29 PM, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
> 
> > If no pinctrl available just report a warning as some architecture may not
> > need to do anything.
> >
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: linux-input@vger.kernel.org
> 
> We're having a discussion on the level of where to impose pinctrl.
> 
> Jean-Christophe, could you please check the thread
> "Input: omap4-keypad: Add pinctrl support"
> and tell us what you think is the best approach?
ok I check it 

Best Regards,
J.
