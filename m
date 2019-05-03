From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: rmi: fix devm_add_action_or_reset() parameter
Date: Fri, 3 May 2019 14:42:18 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1905031440570.10635@cbobk.fhfr.pm>
References: <1555073657-24386-1-git-send-email-fabien.dessenne@st.com> <nycvar.YFH.7.76.1905031418510.10635@cbobk.fhfr.pm> <9628edde-5270-d5a5-7db6-c9ec3f47c742@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9628edde-5270-d5a5-7db6-c9ec3f47c742@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien DESSENNE <fabien.dessenne@st.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, 3 May 2019, Fabien DESSENNE wrote:

> >> -	ret = devm_add_action_or_reset(&hdev->dev, &rmi_irq_teardown, hdata);
> >> +	ret = devm_add_action_or_reset(&hdev->dev, rmi_irq_teardown, hdata);
> > Why do you think this is wrong C?
> 
> Because I was not aware that both func and &func refer to the same 
> function pointer.
> 
> Now I know :)

Yup, it's defined in 6.3.2.1.4 in C99.

-- 
Jiri Kosina
SUSE Labs
