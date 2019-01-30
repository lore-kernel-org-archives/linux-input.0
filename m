From: Federico Vaga <federico.vaga@vaga.pv.it>
Subject: Re: [PATCH v2] doc: Change LXR references to elixir.bootlin.com
Date: Wed, 30 Jan 2019 22:21:51 +0100
Message-ID: <1b313cc4aa1c39d8de7fc1cb95a3d7da@vaga.pv.it>
References: <20190130172528.7552-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130172528.7552-1-j.neuschaefer@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: linux-doc@vger.kernel.org, Kepplinger Martin <Martin.Kepplinger@ginzinger.com>, Stephen Boyd <sboyd@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Markus Heiser <markus.heiser@darmarit.de>, Alessia Mantegazza <amantegazza@vaga.pv.it>, Michael Rodin <michael-git@rodin.online>, Minghui Liu <minghui.liu.95@gmail.com>, Grigory Shipunov <mail@oxapentane.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Coly Li <colyli@suse.de>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>, Guenter Roeck <linux@roeck-us.net>, Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 2019-01-30 18:25, Jonathan Neuschäfer wrote:
> Recently, Free Electrons was renamed to Bootlin[1]. Less recently, the
> Linux Cross Reference (LXR) at lxr.free-electrons.com was replaced by
> Elixir[2], and lxr.free-electrons.com redirected first to
> elixir.free-electrons.com and now to elixir.bootlin.com.
> 
> [1]: https://bootlin.com/blog/free-electrons-becomes-bootlin/
> [2]: https://github.com/free-electrons/elixir
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Acked-by: Federico Vaga <federico.vaga@vaga.pv.it>

> ---
> 
> v2:
> - Fix ident search URL, as suggested by Martin Kepplinger
> - Add trailing slash, which I accidentally dropped in v1 in
>   Documentation/translations/it_IT/process/howto.rst
> 
> v1: 
> https://lore.kernel.org/lkml/20190129142923.5743-1-j.neuschaefer@gmx.net/
> ---
>  Documentation/input/devices/xpad.rst               | 2 +-
>  Documentation/process/howto.rst                    | 2 +-
>  Documentation/process/kernel-docs.rst              | 2 +-
>  Documentation/translations/it_IT/process/howto.rst | 2 +-
>  Documentation/translations/ja_JP/howto.rst         | 2 +-
>  Documentation/translations/ko_KR/howto.rst         | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/input/devices/xpad.rst
> b/Documentation/input/devices/xpad.rst
> index b8bd65962dd8..173c2acda9fd 100644
> --- a/Documentation/input/devices/xpad.rst
> +++ b/Documentation/input/devices/xpad.rst
> @@ -218,7 +218,7 @@ References
>  .. [1] http://euc.jp/periphs/xbox-controller.ja.html (ITO Takayuki)
>  .. [2] http://xpad.xbox-scene.com/
>  .. [3] http://www.markosweb.com/www/xboxhackz.com/
> -.. [4] http://lxr.free-electrons.com/ident?i=xpad_device
> +.. [4] https://elixir.bootlin.com/linux/latest/ident/xpad_device
> 
> 
>  Historic Edits
> diff --git a/Documentation/process/howto.rst 
> b/Documentation/process/howto.rst
> index 00c8ddd2ed2c..64deab5cfb3b 100644
> --- a/Documentation/process/howto.rst
> +++ b/Documentation/process/howto.rst
> @@ -225,7 +225,7 @@ Cross-Reference project, which is able to present
> source code in a
>  self-referential, indexed webpage format. An excellent up-to-date
>  repository of the kernel code may be found at:
> 
> -	http://lxr.free-electrons.com/
> +	https://elixir.bootlin.com/
> 
> 
>  The development process
> diff --git a/Documentation/process/kernel-docs.rst
> b/Documentation/process/kernel-docs.rst
> index 3fb28de556e4..ab12dddc773e 100644
> --- a/Documentation/process/kernel-docs.rst
> +++ b/Documentation/process/kernel-docs.rst
> @@ -565,7 +565,7 @@ Miscellaneous
> 
>      * Name: **Cross-Referencing Linux**
> 
> -      :URL: http://lxr.free-electrons.com/
> +      :URL: https://elixir.bootlin.com/
>        :Keywords: Browsing source code.
>        :Description: Another web-based Linux kernel source code 
> browser.
>          Lots of cross references to variables and functions. You can 
> see
> diff --git a/Documentation/translations/it_IT/process/howto.rst
> b/Documentation/translations/it_IT/process/howto.rst
> index 909e6a55bc43..f9a44b1af89d 100644
> --- a/Documentation/translations/it_IT/process/howto.rst
> +++ b/Documentation/translations/it_IT/process/howto.rst
> @@ -234,7 +234,7 @@ il progetto Linux Cross-Reference, che è in grado
> di presentare codice
>  sorgente in un formato autoreferenziale ed indicizzato. Un eccellente 
> ed
>  aggiornata fonte di consultazione del codice del kernel la potete 
> trovare qui:
> 
> -	http://lxr.free-electrons.com/
> +	https://elixir.bootlin.com/
> 
> 
>  Il processo di sviluppo
> diff --git a/Documentation/translations/ja_JP/howto.rst
> b/Documentation/translations/ja_JP/howto.rst
> index f3116381c26b..2ca9389d5915 100644
> --- a/Documentation/translations/ja_JP/howto.rst
> +++ b/Documentation/translations/ja_JP/howto.rst
> @@ -245,7 +245,7 @@ Linux カーネルソースツリーの中に含まれる、きれいにし、
>  できます。この最新の素晴しいカーネルコードのリポジトリは以下で見つかり
>  ます -
> 
> -	http://lxr.free-electrons.com/
> +	https://elixir.bootlin.com/
> 
>  開発プロセス
>  ------------
> diff --git a/Documentation/translations/ko_KR/howto.rst
> b/Documentation/translations/ko_KR/howto.rst
> index a8197e072599..9fc869087e9c 100644
> --- a/Documentation/translations/ko_KR/howto.rst
> +++ b/Documentation/translations/ko_KR/howto.rst
> @@ -235,7 +235,7 @@ ReST 마크업을 사용하는 문서들은 Documentation/output 에 생성된
>  소스코드를 인덱스된 웹 페이지들의 형태로 보여준다. 최신의 멋진 커널
>  코드 저장소는 다음을 통하여 참조할 수 있다.
> 
> -      http://lxr.free-electrons.com/
> +      https://elixir.bootlin.com/
> 
> 
>  개발 프로세스

-- 
Federico Vaga
http://www.federicovaga.it/
