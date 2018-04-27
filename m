From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 3/3] ASoC: samsung: Use gpio_is_valid()
Date: Fri, 27 Apr 2018 11:34:40 +0200
Message-ID: <5f7a27fc-27ae-c1ed-73cc-497f46d2668b@samsung.com>
References: <cover.1524819051.git.arvind.yadav.cs@gmail.com>
 <f7e9ff7d5d7c559967e9d63f3caff478e05017e8.1524819053.git.arvind.yadav.cs@gmail.com>
 <CGME20180427093444epcas2p185dbba85e2d37bde95ce3929a57c1f01@epcas2p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <f7e9ff7d5d7c559967e9d63f3caff478e05017e8.1524819053.git.arvind.yadav.cs@gmail.com>
Content-language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: alsa-devel@alsa-project.org, jkosina@suse.cz, jikos@kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Arvind,

On 04/27/2018 10:56 AM, Arvind Yadav wrote:
> Replace the manual validity checks for the GPIO with the
> gpio_is_valid().
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

The patch looks good to me but you need to send it directly
to the ASoC maintainers to have it applied.

-- 
Regards,
Sylwester
