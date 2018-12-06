From: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v2 2/4] Input: goodix - Add ADVV28-supply regulator support
Date: Thu, 6 Dec 2018 16:32:13 +0530
Message-ID: <CAMty3ZAHf=66=r47Qs5FO1Gi_ypc8cJkVnTZ0EGKzBRBxOcx8Q@mail.gmail.com>
References: <20181205235220.3461-1-jagan@amarulasolutions.com> <20181205235220.3461-2-jagan@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205235220.3461-2-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Michael Trimarchi <michael@amarulasolutions.com>, linux-amarula@amarulasolutions.com
List-Id: linux-input@vger.kernel.org

On Thu, Dec 6, 2018 at 5:22 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Goodix CTP controllers have AVDD28 pin connected to voltage
> regulator which may not be turned on by default, like for GT5663.
>
> Add support for such ctp used boards by adding voltage regulator
> handling code to goodix ctp driver.

s/ADVV28/AVDD28 on commit head, let me know if you need another
version to update that or is it OK to you to change while applying.
sorry.
