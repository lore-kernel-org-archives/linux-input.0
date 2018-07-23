From: Martin Kepplinger <martink@posteo.de>
Subject: Re: [PATCH 11/11] touchscreen: tsc200x: Use octal permissions
Date: Mon, 23 Jul 2018 07:08:55 +0200
Message-ID: <93e4394e-5f2c-6134-1046-8177cbeaee4c@posteo.de>
References: <20180721191029.25658-1-harshitjain6751@gmail.com>
 <20180721191029.25658-10-harshitjain6751@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180721191029.25658-10-harshitjain6751@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: dev-harsh1998 <harshitjain6751@gmail.com>, trivial@kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Simon Budig <simon.budig@kernelconcepts.de>, Andi Shyti <andi@etezian.org>, Luca Ceresoli <luca@lucaceresoli.net>, Kees Cook <keescook@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 2018-07-21 21:09, dev-harsh1998 wrote:
> WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider usi=
ng octal permissions '0444'.
> +static DEVICE_ATTR(selftest, S_IRUGO, tsc200x_selftest_show, NULL);
>=20
> Signed-off-by: dev-harsh1998 <harshitjain6751@gmail.com>

Acked-by: Martin Kepplinger <martink@posteo.de>
