From: Ed Bordin <edbordin@gmail.com>
Subject: Re: [PATCH] Input: i8042 - add Clevo P650RS to the i8042 reset list
Date: Mon, 24 Apr 2017 13:24:34 +1000
Message-ID: <CA+v5tqft_7tJeNJPjD2XEeppgU-UrmPjfxB-w1=Jfryys98azA@mail.gmail.com>
References: <20170413225152.GA19947@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170413225152.GA19947@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Marcos Paulo de Souza <marcos.souza.org@gmail.com>, =?UTF-8?Q?Pawe=C5=82_Bylica?= <chfast@gmail.com>, Michele Bissacco <mirh@protonmail.ch>, Santi Villalba <sdvillal@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Works for me. Thanks for the fix!

On 14 April 2017 at 08:51, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrot=
e:
> Clevo P650RS and other similar devices require i8042 to be reset in order
> to detect Synaptics touchpad.
>
> Reported-by: Pawe=C5=82 Bylica <chfast@gmail.com>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D190301
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/=
i8042-x86ia64io.h
> index 8da340043611..df52665a7583 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -628,6 +628,13 @@ static const struct dmi_system_id __initconst i8042_=
dmi_reset_table[] =3D {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "20046"),
>                 },
>         },
> +       {
> +               /* Clevo P650RS, 650RP6, Sager NP8152-S, and others */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "P65xRP"),
> +               },
> +       },
>         { }
>  };
>
> --
> 2.12.2.762.g0e3151a226-goog
>
>
> --
> Dmitry
