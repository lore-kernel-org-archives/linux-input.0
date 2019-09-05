From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: sony: Fix memory corruption issue on cleanup.
Date: Thu, 5 Sep 2019 14:27:45 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1909051427340.31470@cbobk.fhfr.pm>
References: <20190904212211.29832-1-roderick@gaikai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190904212211.29832-1-roderick@gaikai.com>
Sender: stable-owner@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>
Cc: linux-input@vger.kernel.org, andreyknvl@google.com, Roderick Colenbrander <roderick.colenbrander@sony.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 4 Sep 2019, Roderick Colenbrander wrote:

> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
> 
> The sony driver is not properly cleaning up from potential failures in
> sony_input_configured. Currently it calls hid_hw_stop, while hid_connect
> is still running. This is not a good idea, instead hid_hw_stop should
> be moved to sony_probe. Similar changes were recently made to Logitech
> drivers, which were also doing improper cleanup.
> 
> Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
> CC: stable@vger.kernel.org

Applied, thanks Roderick.

-- 
Jiri Kosina
SUSE Labs
