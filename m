From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2] drivers: input: mouse: Remove useless casting in
 cypress_ps2.c
Date: Wed, 16 Oct 2013 15:39:58 -0700
Message-ID: <1381963198.22110.73.camel@joe-AO722>
References: <1381962675-26876-1-git-send-email-geyslan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381962675-26876-1-git-send-email-geyslan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Geyslan G. Bem" <geyslan@gmail.com>
Cc: dmitry.torokhov@gmail.com, dudl@cypress.com, kamal@canonical.com, mario_limonciello@dell.com, git@status.e4ward.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-br@googlegroups.com
List-Id: linux-input@vger.kernel.org

On Wed, 2013-10-16 at 19:31 -0300, Geyslan G. Bem wrote:
> Get rid of unnecessary (void *) casting in 'cypress_init' function.
[]
> diff --git a/drivers/input/mouse/cypress_ps2.c b/drivers/input/mouse/cypress_ps2.c
[]
> @@ -680,7 +680,7 @@ int cypress_init(struct psmouse *psmouse)
>  	struct cytp_data *cytp;
>  
>  	cytp = (struct cytp_data *)kzalloc(sizeof(struct cytp_data), GFP_KERNEL);
> -	psmouse->private = (void *)cytp;
> +	psmouse->private = cytp;

If you are going to remove useless casts, please
also remove the unnecessary kzalloc cast too.
