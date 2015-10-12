From: Benson Leung <bleung@google.com>
Subject: Re: [PATCH] input: cyapa: fix the copy paste error on electrodes_rx value
Date: Mon, 12 Oct 2015 10:38:50 -0700
Message-ID: <CANLzEksZ=P4xYW0Tbi6EKtUjLQ8ekVN2fyaSi3w8iCi7-Rz3ag@mail.gmail.com>
References: <1444630624-5127-1-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444630624-5127-1-git-send-email-dudl@cypress.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dudley Du <dudl@cypress.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, sudipm.mukherjee@gmail.com, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sun, Oct 11, 2015 at 11:17 PM, Dudley Du <dudl@cypress.com> wrote:
>
> Fix the copy paste error on the electrodes_rx value set code which will
> cause the electrodes_rx value be always set to the value of electrodes_y.
>
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Reviewed-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Signed-off-by: Dudley Du <dudl@cypress.com>

Reviewed-by: Benson Leung <bleung@chromium.org>

Thanks!
-- 
Benson Leung
Senior Software Engineer, Chrome OS
Google Inc.
bleung@google.com
