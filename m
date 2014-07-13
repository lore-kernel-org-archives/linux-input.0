From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for
 'devm_ioremap_resource'
Date: Sun, 13 Jul 2014 22:28:04 +0800
Message-ID: <53C29774.9000208@gmail.com>
References: <53C1F7DE.3060102@gmail.com> <53C1F98D.9030603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <53C1F98D.9030603@gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, benh@kernel.crashing.org, teg@jklm.no, thierry.reding@gmail.com, Lennox Wu <lennox.wu@gmail.com>, marex@denx.de, Liqin Chen <liqin.linux@gmail.com>, lars@metafoo.de, richard@nod.at, linux-input@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, linux-pwm@vger.kernel.org, devel@driverdev.osuosl.org, linux-watchdog@vger.kernel.org, msalter@redhat.com, dmitry.torokhov@gmail.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, knaack.h@gmx.de, schwidefsky@de.ibm.com, David Rientjes <rientjes@google.com>, Mischa.Jonker@synopsys.com, jic23@kernel.org
List-Id: linux-input@vger.kernel.org

On 07/13/2014 11:14 AM, Chen Gang wrote:
[...]
> And also find a compiler issue, I will try to fix it, but shall not notify
> kernel mailing list, again. The related issue is below (it seems a kernel
> issue, but in fact, it is a compiler's issue):
> 
>     CC [M]  drivers/staging/lustre/lustre/ptlrpc/sec.o
>   drivers/staging/lustre/lustre/ptlrpc/sec.c: In function 'sptlrpc_cli_ctx_expire':
>   drivers/staging/lustre/lustre/ptlrpc/sec.c:309:13: error: 'struct ptlrpc_ctx_ops' has no member named '__die'
>     ctx->cc_ops->die(ctx, 0);
>                ^
>   drivers/staging/lustre/lustre/ptlrpc/sec.c: In function 'ctx_refresh_timeout':
>   drivers/staging/lustre/lustre/ptlrpc/sec.c:594:26: error: 'struct ptlrpc_ctx_ops' has no member named '__die'
>      req->rq_cli_ctx->cc_ops->die(req->rq_cli_ctx, 0);
>                             ^
>   make[5]: *** [drivers/staging/lustre/lustre/ptlrpc/sec.o] Error 1
>   make[4]: *** [drivers/staging/lustre/lustre/ptlrpc] Error 2
>   make[3]: *** [drivers/staging/lustre/lustre] Error 2
>   make[2]: *** [drivers/staging/lustre] Error 2
>   make[1]: *** [drivers/staging] Error 2
>   make: *** [drivers] Error 2
> 

Oh, sorry, after check related details, this is still a kernel issue,
'die' is a macro which defined by most of architectures, so can not
use this common name as a declaration in any other area.

I shall send related patch for it.

Thanks.
-- 
Chen Gang

Open share and attitude like air water and life which God blessed
